class SettingsObject
  include Mongoid::Document
  include Mongoid::Timestamps
  include Ants::Id
  include Ants::Slug

  ## Attributes
  field :title
  field :values, type: Hash, default: {}

  ## Slug
  slug :title

  def values_attributes= (hash)
    values = hash
  end

  ## Class
  def self.hash
    all.to_a.inject({}) { |h, s| h[s.title.to_sym] = s.values; h }
  end
end
