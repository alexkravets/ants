class Book
  include Mongoid::Document
  include Ants::SortedRelations
  include Ants::Slug

  # attributes
  field :title

  slug :title, history: true

  # relations
  has_many :chapters
  sorted_relations_for :chapters

  has_and_belongs_to_many :authors
  sorted_relations_for :authors
end
