class @AntsSlugInput
  constructor: (label="Slug") ->
    config =
      type: "string"
      name: "_slug"
      label: label
      placeholder: " "
      onInitialize: (input) ->
        if input.object && input.object._slugs.length
          defaultSlug = input.object._slugs[0]
          input.$input.attr "placeholder", defaultSlug

    return config
