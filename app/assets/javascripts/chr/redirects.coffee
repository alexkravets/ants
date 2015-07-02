@Ants ||= {}

Ants.redirectsConfig = ->
  showWithParent: true

  arrayStore: new RailsArrayStore({
    resource:    'redirect'
    path:        '/admin/redirects'
    sortBy:      'path_from'
    searchable:  true
  })

  formSchema:
    path_from: { type: 'string', label: 'From', placeholder: '/redirect-from-path', required: true }
    path_to:   { type: 'string', label: 'To',   placeholder: '/redirect-to-path',   required: true }
