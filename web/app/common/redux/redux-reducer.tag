<redux-reducer>

  <yield>
  </yield>

  <script type='text/es6'>
    this.mixin('redux');

    this.on('mount', () => {
      console.log ("Object-Keys:", Object.keys(this.tags));
      Object.keys(this.tags).forEach( (tagName) => {
        console.log ("-->", tagName);
        let reducer = this.tags[tagName].reducer;
        let initState = this.tags[tagName].initState;
        console.log ("InitState: ", initState);
        this.addReducer(this._createReducer(initState, reducer));
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