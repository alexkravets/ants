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
