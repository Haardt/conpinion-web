import { SHOW_VIEW } from './view-actions.js'

export default class ConAppReducer {

      constructor() {
      }

      initState() {
        return { view: '' }
      }

      name() { return 'views'; }

      reducer () { return {
        [SHOW_VIEW](state = initialState, action) {
            return {
              'view': action.view
            }
          }
        }
      }
}