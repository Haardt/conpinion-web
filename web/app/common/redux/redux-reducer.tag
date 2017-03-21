<redux-reducer>

  <yield />

  <script type='es6'>
    this.mixin('redux');

    this.on('mount', () => {
      Object.keys(this.tags).forEach( (tagName) => {
        let reducerName = this.tags[tagName].name();
        let reducer = this.tags[tagName].reducer;
        let initState = this.tags[tagName].initState;
        let getStateSlice = this.tags[tagName].getStateSlice;
        this.addReducer(reducerName, this.createReducer(initState, reducer, getStateSlice));
      });
    });
  </script>
</redux-reducer>