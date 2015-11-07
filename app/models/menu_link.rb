class MenuLink
  include Mongoid::Document
  include Mongoid::Timestamps
  include Ants::Id
  include Ants::Orderable

  ## Attributes
  field :title
  field :url
  field :target_blank, type: Boolean, default: false

  ## Relations
  embedded_in :menu, class_name: 'Menu'
end
