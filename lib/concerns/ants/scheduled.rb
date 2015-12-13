module Ants
  module Scheduled
    extend ActiveSupport::Concern
    included do
      ## Attributes
      field :published_at, type: DateTime

      ## Scopes
      default_scope -> { desc(:published_at) }
      scope :scheduled, -> { where(:published_at.gt => Time.zone.now) }
      scope :published, -> { where( :published_at.lte => Time.zone.now) }

      ## Indexes
      index published_at: -1
    end
  end
end
