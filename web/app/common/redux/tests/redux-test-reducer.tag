<redux-test-reducer>
    <script type="text/es6">
      import { TEST_REDUX} from './redux-actions.js'

      this.initState = {
        data: ''
      }

      this.name = () => 'redux-test';

      this.reducer = {
        [TEST_REDUX](state = initialState, action, slicedState) {
            return {
              'data': action.data
            };
          }
        };
    </script>
</redux-test-reducer>
