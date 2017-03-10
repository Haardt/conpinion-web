import { LOAD_EDITOR_DATA, showEditorData } from './con-editor-actions.js';
import jsonFetch from '../app/con-fetch.js';

export function editorMiddleware (store) {
   return next => action => {
     if (action.type !== LOAD_EDITOR_DATA) {
      return next(action);
     }
     jsonFetch(action.resource).then( (json) => {
     //Why do i have to parse this - i use fetch->json
      next(showEditorData(action.editorName, JSON.parse(json)));
     });
   }
 }