import { LOAD_TABLE_DATA, showTableData } from './con-table-actions.js';
import getJson from '../app/con-fetch.js';

export function tableMiddleware (store) {
         return next => action => {
           if (action.type !== LOAD_TABLE_DATA) {
            return next(action);
           }
           getJson(action.resource).then( (json) => {
           //Why do i have to parse this - i use fetch->json
            next(showTableData(action.tableName, JSON.parse(json)));
           });
         }
       }