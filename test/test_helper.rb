ENV['RAILS_ENV'] ||= 'test'
$:.unshift File.dirname(__FILE__)

require 'rails_app/config/environment'
require 'rails/test_help'
require 'database_cleaner'
require 'minitest/rails/capybara'
require 'mongoid'
require 'mongoid-history'
require 'mongoid_search'
require File.expand_path('../../lib/ants', __FILE__)


Dir[ "#{File.dirname(__FILE__)}/rails_app/**/*.rb" ].each { |f| require f }

# Capybara
Capybara.javascript_driver = :webkit

# DatabaseCleaner
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean_with(:truncation)

class ActiveSupport::TestCase
  def setup
    Author.destroy_all
    Book.destroy_all
    DatabaseCleaner.clean_with(:truncation)
  end
end