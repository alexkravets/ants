# ==========================================================================
#
# IMPORTANT: this default value raises "stack level too deep" if concern is
#            included for existing objects, to fix issue update _position
#            value for all objects like this:
#
#            > ModelClass.all.set(_position: 1000)
#
# ==========================================================================

module Ants
  module Orderable
    extend ActiveSupport::Concern

    included do

      # attributes
      field :_position, type: Float, default: -> { (self.class.all.last.try(:_position) || 1000) + 10 }

      # scopes
      default_scope -> { order_by(_position: :asc) }

      # helpers
      index({ _position: 1 })


    end
  end
end




