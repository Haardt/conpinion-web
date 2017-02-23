import { NEW_ROUTE_SET } from '../router/route-actions.js'

export default class ConAppReducer {

      constructor() {
      }

      initState() {
        return { view: '' }
      }

      name() { return 'views'; }

      reducer () { return {
        [NEW_ROUTE_SET](state = initialState, action) {
            return {
              'view': action.view
            }
          }
        }
      }
}