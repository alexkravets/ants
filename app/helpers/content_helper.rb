module ContentHelper
  def content_meta_tags(object)
    twitter_tags = {
      url: object.canonical_url,
      title: object.meta_title,
      description: object.meta_description,
      image: object.opengraph_image_url,
      card: "summary"
    }

    open_graph_tags = {
      title: object.meta_title,
      description: object.meta_description,
      url: object.canonical_url,
      type: object.meta_type,
      image: object.opengraph_image_url,
      updated_time: object.updated_at.to_i
    }

    set_meta_tags title: object.meta_title,
                  description: object.meta_description,
                  keywords: object.meta_keywords,
                  canonical: object.canonical_url,
                  og: open_graph_tags,
                  twitter: twitter_tags
  end
end
