import { LOAD_TABLE_DATA, showTableData } from './con-table-actions.js';

export function tableMiddleware (store) {
         return next => action => {
           if (action.type !== LOAD_TABLE_DATA) {
            return next(action);
           }
           console.info('LOADING: ', action.type)
           fetch('/users').then((response) => {
            console.log('abcd: ', response);
           });

           return next(showTableData('users', {firstName:'blub', lastName: 'bla'}));
         }
       }