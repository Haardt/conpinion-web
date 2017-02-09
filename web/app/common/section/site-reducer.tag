<site-reducer>
    <script type="text/es6">

      this.initState = {
        site: ''
      }

      this.reducer = {
        ['STATE'](state = initialState, action) {
            console.log ('State reducer called')
            return [ ...state, {'state':'a'} ];
          },
        ['STATE1'](state = initialState, action) {
            console.log ('State1 reducer called')
            return [ ...state, {'state':'a'} ];
          }
        };
    </script>
</site-reducer>
