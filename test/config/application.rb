# Initialize a dummy application that is required to test
# the gem that supplies some behavior to another rails application


#
# Rails
#

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Define the application and configuration
module TestApp
  class Application < Rails::Application
  end
end

# Initialize the application
# Rails.application.initialize!
TestApp::Application.initialize!


#
# Mongoid
#

require "mongoid"

path_to_mongoid_config = File.join(File.dirname(__FILE__), "mongoid.yml")
Mongoid.load!(path_to_mongoid_config)


#
# Ants
#

require "ants"


#
# Models
#

class Book
  include Mongoid::Document
  include Ants::SortedRelations
  include Ants::Hideable
  include Ants::Orderable
  include Ants::Content

  field :title
end

