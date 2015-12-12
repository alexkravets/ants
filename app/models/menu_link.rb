class MenuLink
  include Mongoid::Document
  include Mongoid::Timestamps
  include Ants::Id
  include Ants::Orderable

  ## Attributes
  field :title
  field :url
  field :force_new_tab, type: Boolean, default: false

  ## Relations
  embedded_in :menu, class_name: 'Menu'

  ## Helpers
  def new_tab?
    (!url.start_with?("/") || force_new_tab)
  end
end
