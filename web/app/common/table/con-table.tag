<con-table>
    <yield />

    <table>
      <tr>
        <th each={ columns }> { label } </th>
      </tr>
      <tr each={ dataList }>
        <td each={ columns } > { dataList[key] } </td>
      </tr>
    </table>

    <script type="text/es6">
        import './con-column.tag';
        import { SHOW_TABLE, TABLE_DATA, showTable } from './con-table-actions.js';
        this.mixin('redux');

        this.columns = [];
        this.dataList = {};

        this.on('mount', () => {
          this.columns = this.createColumns(this.tags['con-column']);

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
        });

        this.showTable = (resource) => {
          this.dispatch(showTable(this.opts.tableName, resource));
        }

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
