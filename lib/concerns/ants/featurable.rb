module Ants
  module Featurable
    extend ActiveSupport::Concern
    included do
      ## Attributes
      field :featured, type: Boolean, default: false

      ## Scopes
      scope :featured,     -> { where(featured: true) }
      scope :not_featured, -> { where(featured: false) }

      ## Indexes
      index({ featured: 1 })

      ## Helpers
      def featured?
        self.featured
      end

      def set_featured!
        return if self.featured?
        self.featured = true
        self.save!
      end

      def unset_featured!
        return unless self.featured?
        self.featured = false
        self.save!
      end
    end
  end
end
