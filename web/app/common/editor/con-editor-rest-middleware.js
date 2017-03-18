import {  LOAD_EDITOR_DATA,
          SAVE_EDITOR_DATA,
          showEditorData,
          saveEditorError,
          saveEditorSuccess
       } from './con-editor-actions.js';

import getJson from '../app/con-fetch.js';
import { putJson } from '../app/con-fetch.js';

export function editorMiddleware (store) {
   return next => action => {

     switch (action.type) {
        case LOAD_EDITOR_DATA:
         getJson(action.resource).then(json => {
           //Why do i have to parse this - i use fetch->json
           next(showEditorData(action.editorName, JSON.parse(json)));
         });
         next(action);
        break;
        case SAVE_EDITOR_DATA:
         putJson(action.resource + action.data.id, action.data).then(json => {
            console.log('Put response:', json);
           //Why do i have to parse this - i use fetch->json
           next(saveEditorSuccess(action.editorName, json));
         })
         .catch (error => {
            error.response.json().then (json => {
              console.log('json:', json);
              next(saveEditorError(action.editorName, json));
            })
           });

        break;

        default:
          return next(action);
     }
   }
 }