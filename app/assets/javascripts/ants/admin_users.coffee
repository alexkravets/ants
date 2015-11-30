class @AntsAdminUsers
  constructor: (title='Administrators', apiPath='/admin') ->
    config =
      title: title
      showWithParent: true

      arrayStore: new RailsArrayStore({
        resource: 'admin_user'
        path: "#{ apiPath }/admin_users"
        sortBy: 'name'
        searchable:  true
      })

      formSchema:
        details_panel:
          type: 'group'
          groupClass: 'group-panel'
          title: 'Profile'
          inputs:
            name:
              type: 'string'
              required: true
              label: "Name"
              placeholder: 'Full name'
              onInitialize: (input) ->
                if input.object
                  input.$el.removeClass 'input-required'
                  input.config.disabled = true
                  input._add_disabled()

            email:
              type: 'string'
              required: true
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

        password_panel:
          type: 'group'
          groupClass: 'group-panel'
          title: 'Password'
          inputs:
            password:
              type: 'password'
              required: true
              placeholder: 'Password'
              onInitialize: (input) ->
                if input.object
                  input.$el.removeClass 'input-required'
                  input.$label.html 'Change password'
                  input.config.placeholder = 'Enter new password here, then hit "Save"'
                  input._add_placeholder()

    return config
