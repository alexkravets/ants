@Ants ||= {}

Ants.adminsConfig = ->
  showWithParent: true

  arrayStore: new RailsArrayStore({
    resource:    'admin'
    path:        '/admin/admins'
    sortBy:      'name'
    searchable:  true
  })

  formSchema:
    name:
      type:        'string'
      required:    true
      label:       """Name <small>— to update or add avatar, please register on
                      <a href='http://gravatar.com' target='_blank'>Gravatar</a>
                      using same email address</small>"""
      placeholder: 'Users full name'

    email:
      type:     'string'
      required: true
      onInitialize: (input) ->
        if input.object
          input.$el.removeClass 'input-required'
          input.config.disabled = true
          input._add_disabled()

    password:
      type:     'password'
      required: true
      onInitialize: (input) ->
        if input.object
          input.$el.removeClass 'input-required'
          input.$label.html 'Change Password'
          input.config.placeholder = 'Type new password here to update the current one'
          input._add_placeholder()
