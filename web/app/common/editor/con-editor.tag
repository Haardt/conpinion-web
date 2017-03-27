<con-editor>
    <div class="ui form fluid segment">
        <yield/>
    </div>

    <script type="es6">
        import "./../../../public/app/semantic/components/segment.css";
        import "./../../../public/app/semantic/components/form.css";
        import "./../../../public/app/semantic/components/divider.css";
        import "./../../../public/app/semantic/components/header.css";
        import "./../../../public/app/semantic/components/message.css";
        import "./../../../public/app/semantic/components/list.css";

        import './con-string-field.tag';
        import './con-combobox-field.tag';
        import './con-editor-button.tag';
        import {
            LOAD_EDITOR_DATA,
            SHOW_EDITOR_DATA,
            SAVE_EDITOR_DATA,
            SAVE_EDITOR_ERROR
        } from './con-editor-actions.js';
        this.mixin('redux');

        this.fields = [];
        this.editorDataId = 0;

        this._updateData = (buttonCallback) => {
            let data = {id: this.editorDataId};
            this.fields.forEach(field => {
                field.save(data);
            });
            buttonCallback(data);
        }

        this.on('mount', () => {
            this.addReducer('editor', this.createReducer(
                {},
                {
                    [LOAD_EDITOR_DATA](state = initialState, action,
                                       slicedState) {

                        return {
                            ...state,
                            loadingId: action.id,
                            loadingEditor: action.editorName,
                            [action.editorName]: {
                                ...state[action.editorName],
                                [action.id]: {
                                    loading: true,
                                    cachedData: state[action.editorName]
                                                && state[action.editorName]
                                                && state[action.editorName][action.id]
                                                && state[action.editorName][action.id].data
                                }
                            }
                        }
                    },
                    [SHOW_EDITOR_DATA](state = initialState, action,
                                       slicedState) {
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
                    }
                    ,
                    [SAVE_EDITOR_DATA](state = initialState, action,
                                       slicedState)
                    {
                        return {
                            [action.editorName]: {
                                error: false,
                                saving: true
                            }
                        }
                    }
                    ,
                    [SAVE_EDITOR_ERROR](state = initialState, action,
                                        slicedState)
                    {
                        return {
                            [action.editorName]: {
                                error: true,
                                saving: false,
                                data: action.data
                            }
                        }
                    }
                    ,
                }));
        });

        this.addSubscriber((state) => {
            let editor = state.editor;
            if (this.opts.name === editor.loadingEditor) {
                let editorData = editor[this.opts.name][editor.loadingId];
                if (editorData) {
                    if (editorData.data && editorData.data.id) {
                        this.editorDataId = editorData.data.id;
                    }
                    this.fields.forEach(field => {
                        field.updateState(editorData);
                    });
                    this.update();
                }
            }
        });
        this.addFieldDescription = field => {
            this.fields.push(field);
        }
    </script>
</con-editor>
