<site-reducer>
    <script type="text/es6">

      this.initState = {
        section: ['']
      }

      this.reducer = {
        ['STATE1'](state = initialState, action) {
            console.log ('State reducer called');
            return {'section': action.section};
          },
        ['STATE2'](state = initialState, action) {
            console.log ('State1 reducer called', state);
            return {'section': action.section};
          },
        ['STATE3'](state = initialState, action) {
            console.log ('State1 reducer called', state);
            return {'section': action.section};
          }
        };
    </script>
</site-reducer>
