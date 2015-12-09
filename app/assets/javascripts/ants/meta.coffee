class @AntsMetaGroup
  constructor: (extra_config={}) ->
    config =
      type: 'group'
      inputs:
        _opengraph_image_url:
          type: 'loft-image'
          label: 'Image'

        _meta_title:
          type: 'string'
          label: 'Title'
          limit: 60
          placeholder: "Accurate and concise description of a page's content"

        _meta_description:
          type: 'text'
          label: 'Description'
          limit: 200
          placeholder: 'Advertise content with short summary'

        _meta_keywords:
          type: 'string'
          label: 'Keywords'
          placeholder: 'e.g. keyword1, keyword2, keyword3'

    $.extend(config, extra_config)

    return config
