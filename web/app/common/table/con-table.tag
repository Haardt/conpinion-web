<con-table>
    <yield />

    <table>
      <tr>
        <th each={ columns }> { label } </th>
      </tr>
      <tr each={ data in dataList }>
        <td each={ columns }>
          <virtual data-is={tag} column-value={data[key]}></virtual>
        </td>
        <td>
          <button row-id="{data.id}" onclick={rowEdit}>E</button>
        </td>
      </tr>
    </table>

    <script type="text/es6">
        import './con-column.tag';
        import './con-string-column.tag';
        import './con-input-column.tag';
        import { LOAD_TABLE_DATA, SHOW_TABLE_DATA } from './con-table-actions.js';
        this.mixin('redux');
        this.mixin('router');

        this.columns = [];
        this.dataList = {};

        this.editCallback = (callback) => this.editCallback = callback;

        this.rowEdit = (event) => {
          let id = event.srcElement.attributes['row-id'].nodeValue;
          this.editCallback(id);
        }

        this.on('mount', () => {
          this.columns = this.createColumns(this.tags['con-column']);

          this.addReducer('table', this.createReducer({},
              {
                [LOAD_TABLE_DATA](state = initialState, action, slicedState) {
                    return {
                      [action.tableName]: {
                        loading: true
                      }
                    }
                  },
                  [SHOW_TABLE_DATA](state = initialState, action, slicedState) {
                    return {
                      [action.tableName]: {
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
              key: column.opts.key,
              tag: column.opts.tag
            }
           });
        }

    </script>
</con-table>
