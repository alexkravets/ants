ENV["RAILS_ENV"] ||= "test"

# This adds the current file directory to the load path.
$:.unshift File.dirname(__FILE__)

require 'config/application'
require 'rails/test_help'
require "database_cleaner"
require "mongoid"

# DatabaseCleaner
DatabaseCleaner.strategy = :truncation
DatabaseCleaner[:mongo_mapper].strategy = :truncation

class ActiveSupport::TestCase
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
