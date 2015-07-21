# coding: utf-8

require 'minitest_helper'

require 'gprrr/config'

class Sample
  include Gprrr::Config
end


describe 'Gprrr::Config' do
  before do
    @sample = Sample.new
  end

  describe '.init_config' do
    it 'should have created a configuration' do
      Gprrr::Config.config.must_be_instance_of Configatron
    end
  end

  describe '#config' do
    it 'should get the global configuration' do
      @sample.config.must_be_instance_of Configatron
    end
  end

  describe '#set_config_section' do
    it 'should set the configuration sub-section' do
      @sample.set_config_section('logging').wont_be_nil
      @sample.config.file.path.wont_be_nil
    end
  end
end

