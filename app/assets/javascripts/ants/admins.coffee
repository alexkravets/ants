class @AntsAdmins
  constructor: (title='Admins', apiPath='/admin') ->
    config =
      title: title
      showWithParent: true

      arrayStore: new RailsArrayStore({
        resource:    'admin'
        path:        "#{ apiPath }/admins"
        sortBy:      'name'
        searchable:  true
      })

      formSchema:
        name:
          type:        'string'
          required:    true
          label:       "Name"
          placeholder: 'Full name'
          onInitialize: (input) ->
            if input.object
              input.$el.removeClass 'input-required'
              input.config.disabled = true
              input._add_disabled()

        email:
          type:        'string'
          required:    true
          placeholder: 'Email'

          onInitialize: (input) ->
            if input.object
              input.$el.removeClass 'input-required'
              input.config.disabled = true
              input._add_disabled()

              input.$actions   =$ "<span class='input-actions'></span>"
              input.$avatarBtn =$ "<a href='https://en.gravatar.com/' target='_blank'>Update avatar</a>"
              input.$label.append input.$actions
              input.$actions.append input.$avatarBtn

        password:
          type:        'password'
          required:    true
          placeholder: 'Password'
          onInitialize: (input) ->
            if input.object
              input.$el.removeClass 'input-required'
              input.$label.html 'Change Password'
              input.config.placeholder = 'Type new password here to update the current one'
              input._add_placeholder()

    return config