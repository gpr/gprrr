# coding: utf-8

require 'logger'
require 'gem_template/config'

module GemTemplate
  # Enable logging by sharing the same logger.
  #
  # Adds `include GemTemplate::Logging` to your class to add the `#logger` method.
  #
  # ## Example
  #
  # ```
  # class Sample
  #   include GemTemplate::Logging
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
    def Logging.init_logger
      GemTemplate::Config.init_config
      config = GemTemplate::Config.get_config_section('logging')

      if config.file
        @logger = Logger.new File.open(config.file.path, File::WRONLY | File::APPEND | File::CREAT)
      else
        @logger ||= Logger.new $stdout
      end
      @logger
    end

    # Get the module logger.
    # @return [Logger] the module logger
    def Logging.logger
      @logger
    end

    # Inclusion initialisation
    # @return [Logger] the module logger
    def Logging.included(base)
      Logging.init_logger
    end

    # Get the instance logger.
    # @return [Logger] the module logger
    def logger
      Logging.logger
    end

  end
end
