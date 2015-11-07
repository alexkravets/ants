class @AntsMenu
  constructor: (title, apiPath) ->
    config =
      title: title

      objectStore: new RailsObjectStore({
        resource: 'menu'
        path: "#{ apiPath }"
      })

      formSchema:
        links:
          type: 'documents'
          newButtonLabel: 'Add a Link'
          sortBy: '_position'
          formSchema:
            title:
              type: 'string'

            url:
              type: 'string'

            target_blank:
              type: 'checkbox'
              default: false
              label: 'Open in a new tab'

    return config
