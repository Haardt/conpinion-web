<route-reducer>
    <script type="text/es6">
      import { NEW_ROUTE, NEW_ROUTE_SET } from './route-actions.js'

      this.initState = {
        route: '/'
      }

      this.name = () => 'router';
      this.getStateSlice = (state) => {
        return state['section-manager'];
      }

      this.reducer = {
        [NEW_ROUTE](state = initialState, action, slicedState) {
            return {
              'route': action.route,
              'data': action.data
            };
          },
        [NEW_ROUTE_SET](state = initialState, action, slicedState) {
            return {
              'route': action.route,
              'data': action.data,
              'IGNORE_URL_LINE': true
            };
          }
        };
    </script>
</route-reducer>
