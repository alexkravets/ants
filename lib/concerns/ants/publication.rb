module Ants
  module Publication
    extend ActiveSupport::Concern

    included do
      include Mongoid::Timestamps

      include Ants::Id
      include Ants::Featurable
      include Ants::Orderable
      include Ants::Slug
      include Ants::Meta

      # attributes
      field :title
      field :draft,        type: Boolean,  default: false
      field :published_at, type: DateTime, default: -> { DateTime.now }

      # slug
      slug :title

      # validations
      validates_presence_of :title, :published_at

      # scopes
      scope :drafts,           -> { where(draft: true)                                           }
      scope :ready_to_publish, -> { where(draft: false)                                          }
      scope :scheduled,        -> { ready_to_publish.where(:published_at.gt  => Time.zone.now)   }
      scope :published,        -> { ready_to_publish.where(:published_at.lte => Time.zone.now)   }
      # override featured scope set by Ants::Featured to add ordering by _position
      scope :featured,         -> { unscoped.published.where(featured: true).asc(:_position)     }
      scope :featured_first,   -> { unscoped.desc(:featured).asc(:_position).desc(:published_at) }
      # override default_scope set by Ants::Orderable
      default_scope            -> { desc(:published_at).desc(:created_at)                        }

      # indexes @TODO: verify if these indexes are required
      index({ featured:     -1, _position:   1, published_at: -1 }) # featured first
      index({ featured:     -1, _position:   1 })                   # featured
      index({ published_at: -1, created_at: -1 })                   # default


      # helpers
      def draft?
        self.draft
      end


      def published?
        ! draft? && published_at <= Time.zone.now
      end


      def scheduled?
        ! draft? && published_at > Time.zone.now
      end


      def _list_item_title
        title
      end


      def _list_item_subtitle
        published_at.strftime("%B %d, %Y @ %l:%M %P")
      end


      def meta_title
        _meta_title.present || title
      end


    end
  end
end




