class @AntsSettings
  constructor: (title, slug, formSchema, apiPath='/admin') ->
    config =
      title: title
      showWithParent: true

      objectStore: new RailsObjectStore({
        resource: 'settings_object'
        path: "#{apiPath}/settings_objects/#{slug}"
      })

      formSchema:
        values:
          type: 'hash'
          formSchema: formSchema

      onViewShow: (view) ->
        view.$el.addClass 'view-settings'

    return config
