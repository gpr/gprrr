# coding: utf-8

require 'minitest_helper'

require 'gem_template/logging'
require 'gem_template/config'

class SampleLogging
  include GemTemplate::Logging

  def log_error
    logger.error('Logging: error')
  end

  def log_info
    logger.info('Logging: info')
  end
end

describe 'GemTemplate::Logging' do

  describe '.init_logger' do
    it 'should have loaded configuration' do
      GemTemplate::Config.configatron.must_be_instance_of Configatron
    end

    it 'should have created a logger' do
      GemTemplate::Logging.logger.must_be_instance_of Logger
    end

  end

  describe '#logger' do
    before do
      @sample = SampleLogging.new
    end

    it 'should log error' do
      @sample.log_error
    end
  end
end

