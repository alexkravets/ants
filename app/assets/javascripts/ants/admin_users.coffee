class @AntsAdminUsers
  constructor: (@title='Administrators', @apiPath='/admin') ->
    @showWithParent = true

    @arrayStore = new RailsArrayStore
      resource: "admin_user"
      path: "#{ @apiPath }/admin_users"
      sortBy: "name"
      searchable: true

    @formSchema =
      details_panel:
        type: "group"
        groupClass: "group-panel"
        title: "Profile"
        inputs:
          name:
            type: "string"
            required: true
            label: "Name"
            placeholder: "Enter users full name."
            onInitialize: (input) => @_disable_input_for_edit(input)

          email:
            type: "string"
            required: true
            placeholder: "Enter users email address used to sign in."

            onInitialize: (input) => @_disable_input_for_edit(input)

      password_panel:
        type: "group"
        groupClass: "group-panel"
        title: "Password"
        inputs:
          password:
            type: "password"
            required: true
            placeholder: "Please use a complex password."
            onInitialize: (input) =>
              @_transform_password_to_change_password_on_edit(input)

    @onEditShow = (view) =>
      @_hide_save_button(view)

  # PRIVATE ===================================================================
  _hide_save_button: (view) ->
    view.$saveBtn.hide()

  _disable_input_for_edit: (input) ->
    if input.object
      input.$el.removeClass "input-required"
      input.config.disabled = true
      input._add_disabled()

  _transform_password_to_change_password_on_edit: (input) ->
    if input.object
      input.$el.prev().children(".group-title").html("Change Password")
      input.$el.removeClass "input-required"
      input.$labelTitle.html "New password"
      input.config.placeholder = 'Enter your new password and hit "Update".'
      input._add_placeholder()

      @_add_password_update_action(input)

  _add_password_update_action: (input) ->
      input.$actions   =$ "<span class='input-actions'></span>"
      input.$updateBtn =$ "<button>Update</button>"
      input.$label.append input.$actions
      input.$actions.append input.$updateBtn

      input.$updateBtn.on "click", (e) =>
        @_update_password(input)

  _update_password: (input) ->
    chr.module.view.showSpinner()
    input.hideErrorMessage()

    resourcePath = "#{ @apiPath }/admin_users"
    resourceId = input.object._id
    action = "update_password"
    url = "#{resourcePath}/#{resourceId}/#{action}.json"

    data =
      password: input.$input.val()

    $.ajax
      type: 'PATCH'
      url:  url
      data: data

      success: (response) ->
        chr.module.view.hideSpinner()
        input.$input.val("")
        chr.showNotification "Password has been updated."

      error: (jqXHR) ->
        if jqXHR.responseJSON
          firstErrorMessage = jqXHR.responseJSON[input.config.fieldName][0]
          input.showErrorMessage(firstErrorMessage)

        chr.showError "Your password were not updated. Please fix error and try again."
        chr.module.view.hideSpinner()
