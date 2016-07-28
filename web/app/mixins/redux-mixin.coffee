class ReduxSingleton
  instance = null
  constructor: () ->
    if instance
      return instance
    else
      instance = @
      @store = null
      @reducer = []
      @futureSubscribes = []

  dispatch: (action) ->
    @store.dispatch action
  subscribe: (callback) ->
    if @store?
      @store.subscribe callback
    else
      @futureSubscribes.push callback
  getState: () ->
    @store.getState()

  addReducer: (newReducer) ->
    @reducer.push newReducer

  createStore: () ->
    reduceFunctions = {}
    @reducer.forEach (tag) ->
      console.log "Register '#{tag.reducerName}' reducer."
      reduceFunctions[tag.reducerName] = tag.reduce
    appReducer = Redux.combineReducers reduceFunctions
    console.log appReducer
    @store = Redux.createStore appReducer
    console.log "Store: #{@store}"
    @futureSubscribes.forEach (subscription) => @store.subscribe subscription
    @instance

@ReduxMixin =
  instance: null

  init: () ->
    @instance = new ReduxSingleton()

  dispatch: (action) ->
    @instance.dispatch action

  dispatchAsync: (action) ->
    setTimeout =>
      @instance.dispatch action
    , 0

  subscribe: (callback) ->
    @instance.subscribe callback

  getState: () ->
    @instance.getState()

  addReducer: (reducer) ->
    @instance.addReducer reducer

  createStore: () ->
    @instance.createStore()
