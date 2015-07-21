# coding: utf-8

require 'logger'
require 'gprrr/config'

module Gprrr
  # Enable logging by sharing the same logger.
  #
  # Adds `include Gprrr::Logging` to your class to add the `#logger` method.
  #
  # The logger is initialized with default options if it is not `#init_logger` is not called before.
  #
  # ## Example
  #
  # ```
  # class Sample
  #   include Gprrr::Logging
  # end
  #
  # sample = Sample.new
  # sample.logger.error('an error occurred')
  # ```
  module Logging

    # Module initialization.
    #
    # Create the module logger if it does not exist.
    #
    # @return [Logger] the module logger
    def Logging.init_logger(log_to_file=true, file_path=nil, rotation='daily')
      unless @logger
        Gprrr::Config.init_config
        config = Gprrr::Config.get_config_section('logging')

        if config.file
          if rotation == 'daily'
            file_datetime = Time.now.strftime '%Y%m%d'
          else
            file_datetime = Time.now.strftime '%Y%m%d_%H%M%S'
          end
          file_path ||= File.join(config.file.dir, "#{config.file.name}_#{file_datetime}.log")
        end

        if log_to_file
          @logdev = File.open(file_path, File::WRONLY | File::APPEND | File::CREAT)
          @logger = Logger.new(@logdev, rotation)
        else
          @logger = Logger.new $stdout
          @logger.formatter = proc do |severity, datetime, progname, msg|
            "[#{severity}] #{msg}\n"
          end
        end
      end
      @logger
    end

    # Get the module logger.
    # @return [Logger] the module logger
    def Logging.logger
      @logger ? @logger : Logging.init_logger
    end

    # Close the logger
    # XXX we don't use the #close function of the Logger as it would close the stdout/stderr if we use it
    #     we close only if the output is a file
    def Logging.reset!
      @logdev.close if @logdev
      @logdev = nil
      @logger = nil
    end

    # Get the instance logger.
    # @return [Logger] the module logger
    def logger
      Logging.logger
    end

    # Log an INFO message
    def info(msg)
      msg = "(#{self.class.name}) #{msg}" if logger.level == Logger::DEBUG
      logger.info(msg)
    end

    # Log a WARNING message
    def warning(msg)
      msg = "(#{self.class.name}) #{msg}" if logger.level == Logger::DEBUG
      logger.warn(msg)
    end

    # Log a DEBUG message
    def debug(msg)
      msg = "(#{self.class.name}) #{msg}"
      logger.debug(msg)
    end

    # Log an ERROR message
    def error(msg)
      msg = "(#{self.class.name}) #{msg}" if logger.level == Logger::DEBUG
      logger.error msg
    end
  end
end
