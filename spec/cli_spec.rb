# coding: utf-8

require 'minitest_helper'

require 'optparse'
require 'ostruct'

require 'gem_template/cli'
require 'gem_template/version'

class TestCli < GemTemplate::Cli
  attr_reader :config

  VERSION = [1,0,0]
  PROG_NAME = 'cli-test'
  COPY = 'Copyright (C) 2015 Test Copyright'
  USAGE = "Usage: #{PROG_NAME} [options] --specific <specific_option>"

  def initialize(argv=ARGV)

    @options = OpenStruct.new
    @options.specific = 1

    opt_parser = OptionParser.new do |opts|
      opts.banner = USAGE

      opts.separator ''
      opts.separator 'Mandatory arguments:'

      opts.on('-sSPECIFIC', '--specific SPECIFIC', String, 'Specific options') do |specific|
        @options.specific = specific
      end
    end

    super(opt_parser, nil, argv)
  end

  def main
    @logger.info("Type: %s" % @options.type)
    puts 'MAIN!'
  end
end

describe GemTemplate::Cli do

  describe '#initialize' do
    it 'should be executed correctly without option' do
      cli = TestCli.new
      out, err = capture_io do
        cli.main
      end
      assert_match /MAIN!/, out
    end

    it 'should display help message' do
      out = nil
      out, err = capture_io do
        begin
          cli = TestCli.new ['--help']
            # Rescue from standard exit
        rescue SystemExit
        end
      end
      assert_match /Mandatory arguments:/, out
    end

    it 'should allow to setup configuration file' do
      cli = TestCli.new ['--config', 'spec/data/configuration.yaml']
      assert_equal 'value1', cli.config.test_quoted_string
      assert_equal 'value2', cli.config.test_string

      assert_equal 'password', cli.config.test.db_password
      assert_equal 'username', cli.config.test.db_username
    end
  end
end
