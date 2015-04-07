# coding: utf-8

require 'configatron'
require 'gem_template/logging'

require 'yaml'

module GemTemplate
  # Allows to support shared configuration with configatron.
  #
  # Adds `include GemTemplate::Config` to your class to add the `#config` method.
  #
  # ## Example
  #
  # ```
  # class Sample
  #   include GemTemplate::Config
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
    def Config.init_config
      unless @configatron
        root = File.dirname __dir__
        global_config = File.join(root, '..', 'etc', 'config.yaml')
        home_config = File.join(ENV['HOME'], '.gem_template.yaml')
        config_file = home_config if File.exist?(home_config)
        config_file ||= global_config if File.exist?(global_config)
        if config_file
          config_content = File.read(config_file)
          config = YAML.load(config_content)
          configatron.configure_from_hash(config)
          @config = configatron
        end
      end
    end

    # Inclusion callback.
    def Config.included(base)
      Config.init_config
    end

    # Module configuration.
    # @return [Configatron] the module configuration
    def Config.config
      @config
    end

    # Get configuration section.
    #
    # @return [Configatron] the configatron sub-section
    def Config.get_config_section(section_name=nil)
      section_name ? @config[section_name] : @config
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