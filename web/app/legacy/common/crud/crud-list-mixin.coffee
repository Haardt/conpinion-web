@CrudListMixin =

  init: ->
    if (! @crudConfig?)
      nodeName = @root.nodeName.toLowerCase()
      lastIndex = nodeName.lastIndexOf('-')
      if lastIndex == -1
        console.log 'The crud component name must have a minus in name. Like entity-editor'
        return
      prefix = nodeName.slice 0, lastIndex
      @crudConfig =
        section: "#{prefix}-list"
        stateProperty: "#{prefix}-list"
        actionTypePrefix: prefix
        backRoute: "/#{prefix}"

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.phase == 'START'
      then: (state) =>
        @dispatchAsync type: "#{@crudConfig.actionTypePrefix}-list-request"

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.phase == 'FETCHING'
      then: (state) =>
        @load
          success: (data) =>
            @dispatch
              type: "#{@crudConfig.actionTypePrefix}-list-load"
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
        @dispatch
          type: "#{@crudConfig.actionTypePrefix}-list-show"

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.phase == 'SHOW'
      then: (state) =>
        data = state.entities.map (entry) -> state.entityById[entry]
        @tags["#{@crudConfig.actionTypePrefix}Table"].updateData data

    @sectionSubscribe
      section: @crudConfig.section
      stateProperty: @crudConfig.stateProperty
      when: (state) -> state.phase == 'SYNCING'
      then: (state) =>
        @delete state.deletedEntityId,
          success: (data) =>
            @dispatch
              type: "#{@crudConfig.actionTypePrefix}-list-request"
              data: data
          failure: (error) =>
            @dispatch
              type: "#{@crudConfig.actionTypePrefix}-delete-error"
              error: error
