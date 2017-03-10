<con-table>
    <yield />

    <table>
      <tr>
        <th each={ columns }> { label } </th>
      </tr>
      <tr each={ data in dataList }>
        <td each={ columns }> { data[key] } </td>
      </tr>
    </table>

    <script type="text/es6">
        import './con-column.tag';
        import { LOAD_TABLE_DATA, SHOW_TABLE_DATA } from './con-table-actions.js';
        this.mixin('redux');

        this.columns = [];
        this.dataList = {};

        this.on('mount', () => {
          this.columns = this.createColumns(this.tags['con-column']);

          this.addReducer('table', this.createReducer({},
                  {
                    [LOAD_TABLE_DATA](state = initialState, action, slicedState) {
                        return {
                          ["" + action.tableName]: {
                            loading: true
                          }
                        }
                      },
                      [SHOW_TABLE_DATA](state = initialState, action, slicedState) {
                        return {
                          ["" + action.tableName]: {
                            loading: false,
                            dataList: action.data
                          }
                        }
                      },
                  }));
           });

        this.addSubscriber( (state) => {
          let tableData = state['table'][this.opts.name];
          if (tableData) {
            if (tableData.loading == true) {
            }
            if (tableData.loading == false) {
              if (tableData.dataList) {
                this.dataList = tableData.dataList;
              }
            }
          }
          this.update();
        });

        this.createColumns = (columnTags) => {
          if (! Array.isArray(columnTags)) {
            columnTags = [columnTags];
          }
          return columnTags.map((column) => {
             return {
              label: column.opts.label,
              key: column.opts.key
            }
           });
        }

    </script>
</con-table>
