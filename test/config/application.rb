# Initialize a dummy application that is required to test
# the gem that supplies some behavior to another rails application

#
# Rails
#

require "active_model/railtie"
require "rails/test_unit/railtie"

# Require gems
Bundler.require(*Rails.groups)

# Define the application and configuration
class Application < Rails::Application
end

# Initialize the application
Rails.application.initialize!

#
# Mongoid
#

require "mongoid-history"
path_to_config = File.join(File.dirname(__FILE__), "mongoid.yml")
Mongoid.load!(path_to_config)

#
# Ants
#

require "ants"

# Models
require "#{Rails.root}/test/config/models"
