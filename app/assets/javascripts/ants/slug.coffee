class @AntsSlugInput
  constructor: (extra_config={}) ->
    config =
      type: 'string'
      name: '_slug'
      label: 'Slug'
      placeholder: ''
      onInitialize: (input) ->
        if input.object && input.object._slugs.length
          defaultSlug = input.object._slugs[0]
          input.$input.attr 'placeholder', defaultSlug

    $.extend(config, extra_config)

    return config
