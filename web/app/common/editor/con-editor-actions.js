export const LOAD_EDITOR_DATA     = 'LOAD_EDITOR_DATA';
export const SAVE_EDITOR_DATA     = 'SAVE_EDITOR_DATA';
export const SAVE_EDITOR_ERROR    = 'SAVE_EDITOR_ERROR';
export const SAVE_EDITOR_SUCCESS  = 'SAVE_EDITOR_SUCCESS';
export const SHOW_EDITOR_DATA     = 'SHOW_EDITOR_DATA';

export function loadEditorData(editorName, resource) {
  return {
    type: LOAD_EDITOR_DATA,
    editorName: editorName,
    resource: resource
  }
};

export function saveEditorData(editorName, resource, data) {
  return {
    type: SAVE_EDITOR_DATA,
    editorName: editorName,
    resource: resource,
    data: data
  }
};

export function saveEditorError(editorName, data) {
  return {
    type: SAVE_EDITOR_ERROR,
    editorName: editorName,
    data: data
  }
};

export function saveEditorSuccess(editorName, resource, data) {
  return {
    type: SAVE_EDITOR_SUCCESS,
    editorName: editorName,
    resource: resource,
    data: data
  }
};

export function showEditorData(editorName, data) {
  return {
    type: SHOW_EDITOR_DATA,
    editorName: editorName,
    data: data
  }
};

