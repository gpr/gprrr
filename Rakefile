require 'bundler/gem_tasks'

if ENV['COVERAGE']

  require 'simplecov'
  require 'simplecov-html'
  require 'simplecov-rcov'

  SimpleCov.profiles.define 'gem' do
    add_filter '/spec/'

    add_group 'Binaries', '/exe/'
    add_group 'Libraries', '/lib/'
  end

  class SimpleCov::Formatter::MergedFormatter
    def format(result)
      SimpleCov::Formatter::HTMLFormatter.new.format(result)
      SimpleCov::Formatter::RcovFormatter.new.format(result)
    end
  end

  SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
end

desc 'Run minitest spec test suite'
task :spec do
  SimpleCov.start 'gem' if ENV['COVERAGE']

  $LOAD_PATH.unshift('lib', 'spec')
  Dir.glob('./spec/*_spec.rb') { |f| require f }
end
