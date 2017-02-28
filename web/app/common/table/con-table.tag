<con-table>
    <yield />
    <script type="text/es6">
        import './con-column.tag';
        import { SHOW_TABLE, TABLE_DATA, showTable } from './con-table-actions.js';
        this.mixin('redux');

        this.on('mount', () => {

        this.addReducer('table', this.createReducer({},
                {
                  [SHOW_TABLE](state = initialState, action, slicedState) {
                      return {
                        ["" + action.tableName]: {
                          loading: true
                        }
                      }
                    },
                    [TABLE_DATA](state = initialState, action, slicedState) {
                    console.log("Ich war hier");
                      return {
                        ["" + action.tableName]: {
                          loading: false,
                          data: action.data
                        }
                      }
                    },
                }));
        });
        this.addSubscriber( (state) => {
                          console.log('Table state: ', state['table'][this.opts.name]);
                        });
        this.showTable = (resource) => {
          this.dispatch(showTable(this.opts.tableName, resource));
        }

    </script>
</con-table>
