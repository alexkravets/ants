class Menu
  include Mongoid::Document
  include Mongoid::Timestamps
  include Ants::Id
  include Ants::Slug

  ## Attributes
  field :name

  ## Slug
  slug :name

  ## Relations
  embeds_many :links, class_name: 'MenuLink'
  accepts_nested_attributes_for :links, allow_destroy: true

  ## Index
  index name: 1
end
