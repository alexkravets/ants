require 'coveralls'
Coveralls.wear!('rails')
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

ENV["RAILS_ENV"] ||= "test"

# This adds the current file directory to the load path.
$:.unshift File.dirname(__FILE__)

require 'config/application'
require 'rails/test_help'
require "database_cleaner"
require "mongoid"
require 'minitest/reporters'

# DatabaseCleaner
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean_with(:truncation)

# Minitest::Reporters
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class ActiveSupport::TestCase
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
