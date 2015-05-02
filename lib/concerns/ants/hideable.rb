module Ants
  module Hideable
    extend ActiveSupport::Concern

    included do
      # attributes
      field :hidden, type: Boolean, default: false

      # scopes
      scope :hidden,     -> { where(hidden: true)  }
      scope :not_hidden, -> { where(hidden: false) }

      # indexes
      index({ hidden: 1 })


      # helpers
      def hidden?
        self.hidden
      end


      def hide!
        return if self.hidden?
        self.hidden = true
        self.save!
      end


      def unhide!
        return unless self.hidden?
        self.hidden = false
        self.save!
      end


    end
  end
end




