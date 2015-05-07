require 'coveralls'
Coveralls.wear!

require 'rubygems'
require 'bundler/setup'
require 'rails/all'

require 'rspec'
require 'rspec-aspic'

require 'mongoid'
require File.expand_path('../../lib/ants', __FILE__)


Mongoid.configure do |config|
  config.connect_to('mongoid_ants_test')
end

Dir[ "#{File.dirname(__FILE__)}/support/**/*.rb" ].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.include RSpecAspic
  config.after :each do
    Mongoid.purge!
  end
end