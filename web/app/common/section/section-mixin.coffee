
@SectionMixin =
  active: false
  params: {}
  subscriptions: []
  subscribed: false
  mixinInstance: @

  init: () ->
    # We need a single subscription for all tags
    if ! @isSubscribed()
      @subscribe =>
        state = @getState()
        @subscriptions.forEach (subscription) ->
          if state['section-manager'].section == subscription.section
            if subscription.when(state[subscription.stateProperty]) == true
              subscription.then state[subscription.stateProperty]
      @setSubscribed()

  isSubscribed: =>
    @subscribed
  setSubscribed: =>
    @subscribed = true

  isActive: () ->
    @active

  sectionSubscribe: (subscription) ->
    @subscriptions.push subscription