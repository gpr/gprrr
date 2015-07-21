# coding: utf-8

require 'configatron'
require 'gprrr/logging'

require 'yaml'

module Gprrr
  # Allows to support shared configuration with configatron.
  #
  # Adds `include Gprrr::Config` to your class to add the `#config` method.
  #
  # ## Example
  #
  # ```
  # class Sample
  #   include Gprrr::Config
  # end
  #
  # sample = Sample.new
  # sample.config.logging.file.path
  # sample.set_config_section('logging')
  # sample.config.file.path
  # ```
  module Config
    # Module initialization.
    # @return [Configatron] the configuration
    def Config.init_config(opt_config_file=nil)
      unless @config
        # Load global configuration file
        root = File.dirname __dir__
        global_config = File.join(root, '..', 'etc', 'config.yaml')
        if  File.exist?(global_config)
          config_content = File.read(global_config)
          configatron.configure_from_hash(YAML.load(config_content))
        end

        # Load $HOME configuration file
        home_config = File.join(ENV['HOME'], '.gprrr.yaml')
        if  File.exist?(home_config)
          config_content = File.read(home_config)
          configatron.configure_from_hash(YAML.load(config_content))
        end

        @config = configatron
      end

      # Load optional configuration (e.g from cli)
      if opt_config_file and File.exist?(opt_config_file)
        config_content = File.read(opt_config_file)
        @config.configure_from_hash(YAML.load(config_content))
      end

      @config
    end

    # Module configuration.
    # @return [Configatron] the module configuration
    def Config.config
      @config ? @config : Config.init_config
    end

    # Get configuration section.
    #
    # @return [Configatron] the configatron sub-section
    def Config.get_config_section(section_name=nil)
      section_name ? Config.config[section_name] : Config.config
    end

    # Reset the configuration
    def Config.reset!
      configatron.reset!
      @config = nil
    end

    # Instance configuration.
    # @return [Configatron] the module configuration
    def config
      @config ? @config : Config.config
    end

    # Set instance configuration.
    # @return [Configatron] the configatron sub-section
    def set_config_section(section_name)
      @config = Config.get_config_section(section_name)
    end
  end
end
