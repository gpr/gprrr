# coding: utf-8

require 'minitest_helper'

require 'optparse'
require 'ostruct'

require 'gprrr/cli'
require 'gprrr/version'

class TestCli < Gprrr::Cli
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
    debug("Test logger debug")
    info("Test logger info")
    warning("Test logger warning")
    error("Test logger error")
    puts 'MAIN!'
  end
end

describe Gprrr::Cli do

  describe '#initialize' do

    it 'should be executed correctly without option' do
      cli = TestCli.new
      out, err = capture_io do
        cli.main
      end
      assert_match /MAIN!/, out
    end

    it 'should display help message with --help' do
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

    it 'should display version --version' do
      out = nil
      out, err = capture_io do
        begin
          cli = TestCli.new ['--version']
            # Rescue from standard exit
        rescue SystemExit
        end
      end

      assert_match "#{TestCli::COPY}", out
      assert_match "#{TestCli::PROG_NAME} v#{TestCli::VERSION.join('.')} (gprrr v#{Gprrr::VERSION})", out
    end

    it 'should log to stdout with --no-logfile' do
      Gprrr::Config.reset!
      Gprrr::Logging.reset!

      cli = TestCli.new ['--no-logfile']
      out, err = capture_subprocess_io do
        cli.main
      end
      assert_match /MAIN!/, out
      refute_match /Test logger debug/, out
      refute_match /Test logger info/, out
      assert_match /Test logger warning/, out
      assert_match /Test logger error/, out
    end

    it 'should log verbosely with -V/--verbose' do
      Gprrr::Config.reset!
      Gprrr::Logging.reset!

      cli = TestCli.new ['-v', '--no-logfile']
      out, err = capture_subprocess_io do
        cli.main
      end
      assert_match /MAIN!/, out
      refute_match /Test logger debug/, out
      assert_match /Test logger info/, out
      assert_match /Test logger warning/, out
      assert_match /Test logger error/, out
    end

    it 'should log debug info with -D/--debug' do
      Gprrr::Config.reset!
      Gprrr::Logging.reset!

      cli = TestCli.new ['-D', '--no-logfile']
      out, err = capture_subprocess_io do
        cli.main
      end
      assert_match /MAIN!/, out
      assert_match /Test logger debug/, out
      assert_match /Test logger info/, out
      assert_match /Test logger warning/, out
      assert_match /Test logger error/, out
    end

    it 'should load a custom configuration file with --config' do
      Gprrr::Config.reset!
      Gprrr::Logging.reset!

      cli = TestCli.new ['--config', 'spec/data/configuration.yaml']
      assert_equal 'value1', cli.config.test_quoted_string
      assert_equal 'value2', cli.config.test_string

      assert_equal 'password', cli.config.test.db_password
      assert_equal 'username', cli.config.test.db_username
    end
  end
end
