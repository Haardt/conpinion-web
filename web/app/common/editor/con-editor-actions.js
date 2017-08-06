export const LOAD_EDITOR_DATA = 'LOAD_EDITOR_DATA';
export const SAVE_EDITOR_DATA = 'SAVE_EDITOR_DATA';
export const SAVE_EDITOR_ERROR = 'SAVE_EDITOR_ERROR';
export const SAVE_EDITOR_SUCCESS = 'SAVE_EDITOR_SUCCESS';
export const SHOW_EDITOR_DATA = 'SHOW_EDITOR_DATA';

export function loadEditorData(editorName, id, resource) {
    return {
        type: LOAD_EDITOR_DATA,
        editorName: editorName,
        id: id,
        resource: resource
    }
};

export function showEditorData(editorName, id, data) {
    return {
        type: SHOW_EDITOR_DATA,
        editorName: editorName,
        data: data,
        id: id
    }
};

export function saveEditorData(editorName, editorId, resource, data) {
    return {
        type: SAVE_EDITOR_DATA,
        editorName: editorName,
        editorId: editorId,
        resource: resource,
        data: data
    }
};

export function saveEditorError(editorName, editorId, data) {
    return {
        type: SAVE_EDITOR_ERROR,
        editorName: editorName,
        editorId: editorId,
        data: data
    }
};

export function saveEditorSuccess(editorName, editorId, resource, data) {
    return {
        type: SAVE_EDITOR_SUCCESS,
        editorName: editorName,
        editorId: editorId,
        resource: resource,
        data: data
    }
};
