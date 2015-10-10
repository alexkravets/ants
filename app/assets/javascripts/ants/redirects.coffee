class @AntsRedirects
  constructor: (title='Redirects', apiPath='/admin') ->
    config =
      title: title
      showWithParent: true

      onViewShow: (view) ->
        if view.object
          view.$linkBtn =$ "<a href='#{ view.object.path_from }' class='link open' target='_blank'>Open</a>"
          view.$header.append view.$linkBtn

      arrayStore: new RailsArrayStore({
        resource:    'redirect'
        path:        "#{ apiPath }/redirects"
        sortBy:      'path_from'
        searchable:  true
      })

      formSchema:
        path_from: { type: 'string', label: 'From', placeholder: '/redirect-from-path', required: true }
        path_to:   { type: 'url',    label: 'To',   placeholder: '/redirect-to-path',   required: true }

    return config