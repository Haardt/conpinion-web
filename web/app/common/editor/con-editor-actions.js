export const LOAD_EDITOR_DATA = 'LOAD_EDITOR_DATA';
export const SHOW_EDITOR_DATA = 'SHOW_EDITOR_DATA';

export function loadEditorData(editorName, resource) {
  return {
    type: LOAD_EDITOR_DATA,
    editorName: editorName,
    resource: resource
  }
};

export function showEditorData(editorName, data) {
  return {
    type: SHOW_EDITOR_DATA,
    editorName: editorName,
    data: data
  }
};

