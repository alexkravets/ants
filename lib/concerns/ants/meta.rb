module Ants
  module Meta
    extend ActiveSupport::Concern
    included do
      field :_meta_title,          default: ''
      field :_meta_description,    default: ''
      field :_meta_keywords,       default: ''
      field :_opengraph_image_url, default: ''

      # these helpers to be used for meta_tags helper,
      # override them to add custom logic
      def meta_title
        _meta_title
      end

      def meta_description
        _meta_description
      end

      def meta_keywords
        _meta_keywords
      end

      def opengraph_image_url
        _opengraph_image_url
      end
    end
  end
end


