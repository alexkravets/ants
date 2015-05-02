class Book
  include Mongoid::Document
  include Ants::SortedRelations

  # attributes
  field :title

  # relations
  has_many :chapters
  sorted_relations_for :chapters

  has_and_belongs_to_many :authors
  sorted_relations_for :authors
end
