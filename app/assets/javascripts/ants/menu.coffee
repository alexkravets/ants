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
          # force_new_tab:
          #   type: 'checkbox'
          #   default: false
          #   label: 'Open in a new tab'

          title:
            type: "string"
            placeholder: "Title"

          url:
            type: "url"
            placeholder: "Path or URL, e.g. /about"

    @onViewShow = (view) ->
      view.$el.addClass "view-menu"
