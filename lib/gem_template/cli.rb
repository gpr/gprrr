# coding: utf-8

module GemTemplate

  require 'optparse'
  require 'ostruct'
  require 'logger'
  require 'mail'
  require 'yaml'

  require 'ruby-progressbar'
  require 'configatron'

  # Class to specialize for generating console command
  class Cli

    # Class initialization
    #
    # @param [OptionParser] opts parser generated by the inherited class
    # @param [Hash] subcommands set of sub OptionParser
    # @param [Array] argv essentially for testing/debugging purposes
    def initialize(opts, subcommands=nil, argv=ARGV)
      @body ||= '\n'
      @options.recipients = ''
      @options.verbose = false
      @options.debug = false
      @options.progress = true
      @options.log_to_file = true
      @options.config_file = File.join(ENV['HOME'], '.gem_template')

      opts.separator ''
      opts.separator 'Common options:'

      # Boolean switch. Enable email notification.
      opts.on('-CCONFIG_FILE', '--config CONFIG_FILE', 'Configuration file' ) do |config_file|
        @options.config_file = config_file
      end

      # Boolean switch. Enable email notification.
      opts.on('-N', '--[no-]notify', 'Enable mail notification (default is false)' ) do |n|
        @options.notification = n
      end

      # Boolean switch. Enable email notification.
      opts.on('-TRECIPIENTS', '--to RECIPIENTS', 'Mail notification recipients' ) do |recipients|
        @options.recipients = recipients
      end

      # Boolean switch. Enable verbose mode.
      opts.on('-v', '--[no-]verbose', 'Run verbosely (default is false)') do |v|
        @options.verbose = v
      end

      # Boolean switch. Enable debug mode.
      opts.on('-D', '--[no-]debug', 'Debug mode (default is false)') do |d|
        @options.debug = d
      end

      # Boolean switch. Enable progress bar.
      opts.on('-P', '--[no-]progress', 'Display progress and logs to file (default is true)') do |p|
        @options.progress = p
      end

      # Boolean switch. Enable logfile
      opts.on('-L', '--[no-]logfile', 'Use logfile instead of STDOUT (default is true)') do |l|
        @options.log_to_file = l
      end

      # Display help message
      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit 0
      end

      # Display version
      opts.on_tail('--version', 'Show version') do
        puts "#{self.class::PROG_NAME} v#{self.class::VERSION.join('.')} (gem_template v#{GemTemplate::VERSION})"
        puts ""#{self.class::COPY}."
        exit 0
      end

      # Manage subcommands
      if subcommands
        @subcommand_options = OpenStruct.new

        args = opts.order!(argv)
        @options.subcommand = args.shift

        if @options.subcommand.nil? or subcommands[@options.subcommand].nil?
          @logger.error('Invalid subcommand')
          self.usage
          exit 1
        end

        @args = subcommands[@options.subcommand].order!
      else
        @args = opts.parse!(argv)
      end

      # Logfile
      if @options.log_to_file
        if @options.notification
          @log_filename = "'#{self.class::PROG_NAME}_#{Time.now.strftime '%Y%m%d_%H%M%S'}.log'"
          @logger = Logger.new(@log_filename)
        else
          @log_filename = "'#{self.class::PROG_NAME}_#{Time.now.strftime '%Y%m%d'}.log'"
          @logger = Logger.new(@log_filename, 'daily')
        end

      else
        @logger = Logger.new(STDOUT)
        @logger.formatter = proc do |severity, datetime, progname, msg|
          '[#{severity}] #{msg}\n'
        end
      end

      if @options.debug
        @logger.level = Logger::DEBUG
      elsif @options.verbose or @options.log_to_file
        @logger.level = @logger.level = Logger::INFO
      else
        @logger.level = Logger::WARN
      end

      # Mail configuration
      Mail.defaults do
        delivery_method :smtp, address: 'TODO', domain: 'TODO'
      end

      begin
        config_content = File.read(@options.config_file)
        config = YAML.load(config_content)
      rescue
        @logger.warn 'Invalid configuration file '#{@options.config_file}''
      end

      configatron.configure_from_hash(config) if config

      @config = configatron
    end

    # Create a progress bar
    def progress_bar(title, total, unit)
      # %t: Title
      # %a: Elapsed (absolute) time
      # %E: Estimated time (will fall back to ETA: > 4 Days when it exceeds 99:00:00)
      # %p: Percentage complete represented as a whole number (eg: 82)
      # %c: Number of items currently completed
      # %C: Total number of items to be completed
      # %B: The full progress bar including 'incomplete' space (eg: ==========)
      # %b: Progress bar only (eg: ==========)
      # %r: Rate of Progress as a whole number (eg: 13)
      # %i: Display the incomplete space of the bar (this string will only contain whitespace eg: )
      # %%: A literal percent sign %
      @bar = ProgressBar.create(format: '%a [%bᗧ%i] %c/%C %t (%p%%) -- %r #{unit}/sec',
                                progress_mark: ' ',
                                remainder_mark: '･',
                                total: total,
                                title: title) if @options.progress
    end

    # Increment the progress bar
    def bar_increment
      @bar.increment if @options.progress and @bar
    end

    # Increment the progress bar with error marker
    def bar_error_increment
      if @options.progress and @bar
        @bar.progress_mark = '!'
        @bar.increment
        @bar.progress_mark = ' '
      end
    end

    # Finish the progress bar
    def bar_finish
      @bar.finish if @options.progress  and @bar
    end

    # Finish the CLI execution
    def finish(errors=0, last_msg=nil, subject=nil)

      if last_msg
        puts last_msg
        @logger.info(last_msg)
      end

      subject ||= '#{self.class::PROG_NAME} execution finished'
      body = @body + '\n#{last_msg}\n\nSee attachment for more information\n'
      if errors != 0
        mail_error(subject, body)
      else
        mail_success(subject, body)
      end

      bar_finish
      send_mail
    end

    # -------------------------------------------------------------------------
    # Mail notification functions

    # Send the email notification
    def send_mail
      @mail.deliver! if @mail and @options.notification
    end

    # Create an email
    def mail(subject, body)

      prog_name = self.class::PROG_NAME
      log_to_file = @options.log_to_file
      log_filename = @log_filename
      recipients = @options.recipients
      @mail = Mail.new do
        from    'noreply@gem_template.com'
        to      recipients
        subject '[#{prog_name}]#{subject}'
        body    body
        add_file log_filename if log_to_file
      end
    end

    # Create an error email notification
    def mail_error(subject, body)
      mail('[ERROR] #{subject}', body) if @options.notification
    end

    # Create an success email notification
    def mail_success(subject, body)
      mail('[SUCCESS] #{subject}', body) if @options.notification
    end

    # Create an informative email notification
    def mail_info(subject, body)
      mail('[INFO] #{subject}', body) if @options.notification
    end

    # -------------------------------------------------------------------------
    # Message functions

    # Display usage
    def usage
      puts self.class::USAGE
    end

    # Display and log verbose message
    def verbose(msg)
      if @options.log_to_file
        puts msg if @options.verbose
      else
        info msg
      end
    end

    # Display, log and add to email notification
    # @param msg Message
    def print_to_all(msg)
      if @options.notification
        @body += '#{msg}\n'
      end

      puts msg
      info(msg) if @options.log_to_file
    end

    # Log an INFO message
    def info(msg)
      @logger.info(msg)
    end

    # Log a WARNING message
    def warning(msg)
      @logger.warn(msg)
    end

    # Log a DEBUG message
    def debug(msg)
      @logger.debug(msg)
    end

    # Log an ERROR message
    def error(msg)
      @logger.error msg
    end

  end

end