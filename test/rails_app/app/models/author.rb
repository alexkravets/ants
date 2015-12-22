class Author
  include Mongoid::Document
  include Ants::Slug

  # attributes
  field :name
  field :nickname, default: ''

  field :_slug, default: ''
  
  slug :name

  # relations
  has_and_belongs_to_many :books
end
