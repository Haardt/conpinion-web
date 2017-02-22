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
        let getStateSlice = this.tags[tagName].getStateSlice;
        this.addReducer(reducerName, this._createReducer(initState, reducer, getStateSlice));
      });
    });

    this._createReducer = (initState, handlers, getStateSlice) => {
        return (state = initState, action) => {
          if (handlers.hasOwnProperty(action.type)) {
            return handlers[action.type](state, action, (getStateSlice || (()=>{})) (this.getState()));
          } else {
            return state
          }
        }
      }

  </script>
</redux-reducer>