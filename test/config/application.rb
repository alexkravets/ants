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
require "mongoid-history"
require "mongoid_search"

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
  include Ants::Featurable
  include Ants::Orderable
  include Ants::Content

  # attributes
  field :title

  slug :title

  # relations
  has_many :chapters
  sorted_relations_for :chapters

  has_and_belongs_to_many :authors
  sorted_relations_for :authors
end

class AuthorHistoryTracker
  include Mongoid::History::Tracker
end

class Author
  include Mongoid::Document
  include Ants::Slug
  include Ants::OrderableReverse
  include Mongoid::History::Trackable
  include Ants::Versions
  include Ants::Id

  # attributes
  field :name
  field :nickname, default: ""
  field :genre_ids, type: Array, default: []
  field :language_id

  field :_slug, default: ""

  slug :name

  track_history class_name:     "AuthorHistoryTracker",
                only:           [:name],
                except:         [],
                on:             [:create, :update, :destroy],
                changes_method: :changes,
                parent:         nil,
                inverse_of:     nil

  # relations
  has_and_belongs_to_many :books
end

class Chapter
  include Mongoid::Document

  # attributes
  field :title

  # relations
  belongs_to :book
end
