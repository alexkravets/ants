module Ants
  module Content
    extend ActiveSupport::Concern

    included do
      include Mongoid::Document
      include Mongoid::Timestamps
      include Mongoid::Search
      include Ants::Id
      include Ants::Slug
      include Ants::Hideable
      include Ants::Meta

      ## Attributes
      field :title
      field :body_markdown
      field :body_html

      ## Validation
      validates_presence_of :title

      ## Search & Slug
      search_in :title
      slug :title

      ## Helpers
      alias_attribute :_list_item_title, :title

      def canonical_url
        "#{protocole}#{host}/#{slug}"
      end

      def meta_type
        "article"
      end

      def meta_title
        _meta_title.presence || title
      end

      def meta_description
        _meta_description.presence
      end

      def meta_keywords
        _meta_keywords.presence
      end

      def opengraph_image_url
        url = _opengraph_image_url.presence
        if url
          if !url.include?('//')
            "#{protocole}#{host}#{url}"
          else
            url
          end
        else
          ""
        end
      end

      protected

      def host
        @host ||= ENV.fetch("HOST")
      end

      def protocole
        @protocole ||= Rails.application.config.force_ssl ? "https://" : "http://"
      end
    end
  end
end
