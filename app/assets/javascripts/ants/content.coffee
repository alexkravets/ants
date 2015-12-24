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
          body_html:
            type: "hidden"
          body_markdown:
            type: "markdown"
            getHtmlInput: -> chr.module.view.form.inputs.body_html

      settings:
        type: "group"
        groupClass: "group-content-settings"
        inputs:
          general_panel:
            type: "group"
            groupClass: "group-panel group-content-settings"
            inputs:
              hidden:
                type: "switch"
                label: "Draft"
                default: true

          sharing_panel:
            type: "group"
            groupClass: "group-panel"
            title: "Sharing"
            inputs:
              @_meta_inputs()

    @onNewShow = (view) =>
      view.form.inputs.title.$input.focus()

    @onEditShow = (view) =>
      view.form.inputs.body_markdown.editor.focus()
      @_update_slug_label(view)

    @onSaveSuccess = (view) =>
      @_update_slug_label(view)
      @_update_preview_href(view.form)

    @onViewShow = (view) =>
      @_toggle_draft_fields(view)
      @_add_editor_panel(view)

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

  _add_editor_panel: (view) ->
    $editorGroup = view.form.groups[0].$el
    view.$editorPanel =$ "<div class='group-content-editor-panel'>"
    $editorGroup.append view.$editorPanel
    @_add_publish_button(view)
    @_add_unpublish_button(view)

  _add_publish_button: (view) ->
    view.$publishBtn =$ "<button class='publish'>Publish</button>"
    view.$publishBtn.on "click", (e) => @_publish(view)
    view.$editorPanel.append view.$publishBtn

  _add_unpublish_button: (view) ->
    view.$unpublishBtn =$ "<button class='unpublish'>Revert to Draft</button>"
    view.$unpublishBtn.on "click", (e) => @_unpublish(view)
    view.$editorPanel.append view.$unpublishBtn

  _publish: (view) ->
    view.form.inputs.hidden.updateValue(false)
    view.$saveBtn.trigger("click")

  _unpublish: (view) ->
    view.form.inputs.hidden.updateValue(true)
    view.$saveBtn.trigger("click")

  _toggle_draft_fields: (view) ->
    if view.object
      hide = view.object.hidden
    else
      hide = true

    $viewEl = view.$el
    $hiddenInput = view.form.inputs.hidden.$input

    $hiddenInput.on "change", (e) ->
      hide = $(e.currentTarget).prop("checked")
      $viewEl.toggleClass("view-content-draft", hide)

    $viewEl.toggleClass("view-content-draft", hide)
