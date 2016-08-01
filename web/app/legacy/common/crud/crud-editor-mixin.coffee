@CrudEditorMixin =

  init: ->
    @entity = { }

    @loading = false
    @modifying = false
    if (! @crudConfig?)
      nodeName = @root.nodeName.toLowerCase()
      lastIndex = nodeName.lastIndexOf('-')
      if lastIndex == -1
        return
      prefix = nodeName.slice 0, lastIndex

      @crudConfig =
        section: "#{prefix}-editor"
        stateProperty: "#{prefix}-entity"
        actionTypePrefix: prefix
        backRoute: "/#{prefix}s"

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.requestParams.path != 'new' && state.phase == 'START'
      then: (state) =>
        @entity.id = state.requestParams.path
        @dispatchAsync type: "#{@crudConfig.actionTypePrefix}-entity-request"
        @loading = true

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.requestParams.path == 'new' && state.phase == 'START'
      then: (state) =>
        @update()
        @dispatchAsync type: "#{@crudConfig.actionTypePrefix}-entity-show"
        @loading = false

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.phase == 'FETCHING'
      then: (state) =>
        @load
          success: (data) =>
            @dispatch
              type: "#{@crudConfig.actionTypePrefix}-entity-load"
              data: data
          failure: (error) =>
            @dispatch
              type: "#{@crudConfig.actionTypePrefix}-load-error"
              error: error

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.phase == 'LOADED'
      then: (state) =>
        @dispatchAsync
          type: "#{@crudConfig.actionTypePrefix}-entity-show"

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.phase == 'SHOW' && state.editObject == null && state.createdObject == null
      then: (state) =>
        @loading = false
        if (state.requestParams.path == 'new')
          @entity = { id: 'new'}
          @newEntity()
        else
          @entity = state.entityById[state.editorId]
        @update()

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.editObject != null && state.phase == 'SYNCING'
      then: (state) =>
        @modifying = true
        @update()
        @save
          success: (data) =>
            @dispatchAsync
              type: "#{@crudConfig.actionTypePrefix}-entity-synced"
          failure: (error) =>
            @saveError error

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.createdObject != null && state.phase == 'SYNCING'
      then: (state) =>
        @save
          success: (data) =>
            @dispatchAsync
              type: "#{@crudConfig.actionTypePrefix}-entity-synced"
          failure: (error) =>
            @saveError error

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.phase == 'SYNCED'
      then: (state) =>
        @modifying = false
        @update()
        @route @crudConfig.backRoute

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.phase == 'LOAD-ERROR'
      then: (state) =>
        @loadError state.error
