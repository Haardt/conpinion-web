<site-reducer>
    <script type="text/es6">

      this.initState = {
        section: ['']
      }

      this.name = () => 'site-manager';

      this.reducer = {
        ['SHOW_SECTION'](state = initialState, action) {
            return {'section': action.section};
          },
        };
    </script>
</site-reducer>
