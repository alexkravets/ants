class @AntsContent
  constructor: (@resourceName="Document") ->
    @disableDelete = true

    @viewTabs =
      editor: @resourceName
      settings: "Options"

    @formSchema =
      editor:
        type: "group"
        groupClass: "group-content-editor"
        onInitialize: (form, group) =>
          @_add_actions(form, group)
        inputs:
          title:
            type: "string"
            placeholder: "#{@resourceName} Title"
          slug: new AntsSlugInput("#{location.origin}/")
          body_markdown:
            type: "markdown"
            label: "Content"
            htmlFieldName: "body_html"
            placeholder: "Content"

      settings:
        type: "group"
        groupClass: "group-content-settings"
        inputs:
          sharing_panel:
            type: "group"
            groupClass: "group-panel"
            title: "Sharing"
            inputs:
              @_meta_inputs()

          general_panel:
            type: "group"
            groupClass: "group-panel group-content-settings"
            inputs:
              hidden:
                type: "switch"
                label: "Draft"
                default: true


    @onEditShow = (view) =>
      @_update_slug_label(view)

    @onSaveSuccess = (view) =>
      @_update_slug_label(view)
      @_update_preview_href(view.form)

  # PRIVATE ===================================================================

  _update_slug_label: (view) ->
    if @_path
      path = @_path(view.object)
      view.form.inputs.slug.$label.text(path)

  _update_preview_href: (form) ->
    if @_preview_url
      object = form.object
      $button = form.groups[0].$previewBtn
      preview_url = @_preview_url(object)
      $button.attr("href", preview_url)

  _add_delete_button: (form, group) ->
    group.$deleteBtn =$ """
      <a href='#' target='_blank' class='content-delete'>
        #{Icons.delete}
      </a>"""
    group.$actions.prepend group.$deleteBtn
    group.$deleteBtn.on 'click', (e) -> chr.module.view._delete(e)

  _add_preview_button: (form, group) ->
    group.$previewBtn =$ """
      <a href='#' target='_blank' class='content-preview'>
        #{Icons.preview}
      </a>"""
    group.$actions.prepend group.$previewBtn
    if form.object
      @_update_preview_href(form)

  _add_actions: (form, group) ->
    group.$actions =$ "<div class='group-content-editor-actions'/>"
    group.$el.prepend group.$actions

    @_add_delete_button(form, group)
    @_add_preview_button(form, group)

  _meta_inputs: ->
    opengraph_image_url:
      name: '_opengraph_image_url'
      type: 'loft-image'
      label: 'Image'
      fullsizePreview: true

    meta_title:
      name: "_meta_title"
      type: "string"
      label: false
      placeholder: "Title"

    meta_description:
      name: "_meta_description"
      type: "text"
      label: false
      placeholder: "Content summary"
