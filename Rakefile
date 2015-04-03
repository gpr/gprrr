require 'bundler/gem_tasks'

desc 'Run minitest spec test suite'
task :spec do
  $LOAD_PATH.unshift('lib', 'spec')
  Dir.glob('./spec/*_spec.rb') { |f| require f }
end
