<redux-reducer>

  <yield>
  </yield>

  <script type='text/es6'>
    this.mixin('redux');

    this.on('mount', () => {
      Object.keys(this.tags).forEach( (tagName) => {
        let reducerName = this.tags[tagName].name();
        let reducer = this.tags[tagName].reducer;
        let initState = this.tags[tagName].initState;
        this.addReducer(reducerName, this._createReducer(initState, reducer));
      });
    });

    this._createReducer = (initState, handlers) => {
        return function reducer(state = initState, action) {
          if (handlers.hasOwnProperty(action.type)) {
            return handlers[action.type](state, action)
          } else {
            return state
          }
        }
      }

  </script>
</redux-reducer>