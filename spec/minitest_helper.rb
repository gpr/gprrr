$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'gem_template'

require 'minitest/autorun'
require 'minitest/reporters'
require 'ci/reporter/rake/minitest'

MiniTest::Reporters.use! [MiniTest::Reporters::SpecReporter.new,
                          MiniTest::Reporters::JUnitReporter.new('spec/reports')]

if ENV['COVERALLS']
  require 'coveralls'
  Coveralls.wear!
end
