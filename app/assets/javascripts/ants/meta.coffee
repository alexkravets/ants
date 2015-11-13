class @AntsMetaGroup
  constructor: (extra_config={}) ->
    config =
      type: 'group'
      inputs:
        _meta_title:
          type: 'string'
          label: 'Meta Title'
          limit: 60
          placeholder: "Accurate and concise description of a page's content"

        _meta_description:
          type: 'text'
          label: 'Meta Description'
          limit: 200
          placeholder: 'Advertise content with short summary'

        _meta_keywords:
          type: 'text'
          label: 'Meta Keywords'
          placeholder: 'e.g. keyword1, keyword2, keyword3'

        _opengraph_image_url:
          type: 'loft-image'
          label: 'Open Graph Image'

    $.extend(config, extra_config)

    return config
