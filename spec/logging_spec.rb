# coding: utf-8

require 'minitest_helper'

require 'gprrr/logging'
require 'gprrr/config'

class SampleLogging
  include Gprrr::Logging

  def log_error
    logger.error('Logging: error')
  end

  def log_info
    logger.info('Logging: info')
  end
end

describe 'Gprrr::Logging' do

  describe '.init_logger' do
    it 'should have loaded configuration' do
      Gprrr::Config.configatron.must_be_instance_of Configatron
    end

    it 'should have created a logger' do
      Gprrr::Logging.logger.must_be_instance_of Logger
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

