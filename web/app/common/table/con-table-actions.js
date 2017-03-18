export const LOAD_TABLE_DATA = 'LOAD_TABLE_DATA';
export const SHOW_TABLE_DATA = 'SHOW_TABLE_DATA';

export function loadTableData(tableName, resource) {
  return {
    type: LOAD_TABLE_DATA,
    tableName: tableName,
    resource: resource
  }
};

export function showTableData(tableName, data) {
  return {
    type: SHOW_TABLE_DATA,
    tableName: tableName,
    data: data
  }
};
