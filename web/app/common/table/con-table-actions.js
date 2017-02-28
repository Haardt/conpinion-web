export const SHOW_TABLE = 'SHOW_TABLE';
export const FETCH_TABLE_DATA = 'FETCH_TABLE_DATA';
export const TABLE_DATA = 'TABLE_DATA';

export function showTable(tableName, resource) {
  return {
    type: SHOW_TABLE,
    tableName: tableName,
    resource: resource
  }
};

export function showTableData(tableName, data) {
  return {
    type: TABLE_DATA,
    tableName: tableName,
    data: data
  }
};

