class @AntsMenu
  constructor: (@title, @apiPath) ->
    @objectStore = new RailsObjectStore
      resource: 'menu'
      path: "#{ @apiPath }"

    @formSchema =
      links:
        type: 'documents'
        newButtonLabel: 'Add a Link'
        sortBy: '_position'
        label: false
        formSchema:
          title:
            type: "string"
            placeholder: "Title"

          url:
            type: "url"
            placeholder: "Path or URL, e.g. /about"
            onInitialize: (input) =>
              @_add_preview_action(input)

    @onViewShow = (view) ->
      view.$el.addClass "view-menu"

  _add_preview_action: (input) ->
    input.$actions =$ "<span class='input-actions'></span>"
    input.$el.append input.$actions

    input.$previewBtn =$ """<a href='#{input.value}' target='_blank'>
                              #{Icons.preview}
                            </a>"""
    input.$actions.append input.$previewBtn

    input.$input.on "change", (e) ->
      link = input.$input.val()
      input.$previewBtn.attr "href", link
