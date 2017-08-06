import {
    LOAD_EDITOR_DATA,
    SHOW_EDITOR_DATA,
    SAVE_EDITOR_DATA,
    SAVE_EDITOR_ERROR
} from './con-editor-actions.js';

export default class ConEditorReducer {

    constructor() {
    }

    initState() {
        return {}
    }

    name() {
        return 'editor';
    }

    reducer() {
        let editorReducer =
        {
            [LOAD_EDITOR_DATA](state = initialState, action,
                               slicedState)
            {
                return {
                    ...state,
                    loadingEditor: action.editorName,
                    [action.editorName]: {
                        ...state[action.editorName],
                        loadingId: action.id,
                        [action.id]: {
                            loading: true,
                            cachedData: state[action.editorName]
                                        && state[action.editorName][action.id]
                                        && state[action.editorName][action.id].data
                        }
                    }
                }
            },
            [SHOW_EDITOR_DATA](state = initialState, action,
                               slicedState)
            {
                return {
                    ...state,
                    [action.editorName]: {
                        ...state[action.editorName],
                        [action.id]: {
                            loading: false,
                            data: action.data
                        }
                    }
                };
            },
            [SAVE_EDITOR_DATA](state = initialState, action,
                               slicedState)
            {
                return {
                    ...state,
                    [action.editorName]: {
                        ...state[action.editorName],
                        [action.editorId]: {
                            error: false,
                            saving: true,
                            data: action.data
                        }
                    }
                }
            },
            [SAVE_EDITOR_ERROR](state = initialState, action,
                                slicedState)
            {
                return {
                    ...state,
                    [action.editorName]: {
                        ...state[action.editorName],
                        [action.editorId]: {
                            error: true,
                            saving: false,
                            data: action.data
                        }
                    }
                }
            }
        };
        return editorReducer;
    }
}