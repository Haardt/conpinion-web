<route-reducer>
    <script type="text/es6">
      import { NEW_ROUTE } from './route-actions.js'

      this.initState = {
        route: '/'
      }

      this.name = () => 'router';

      this.reducer = {
        [NEW_ROUTE](state = initialState, action) {
            return {
              'route': action.route,
              'data': action.data
            };
          }
        };
    </script>
</route-reducer>
