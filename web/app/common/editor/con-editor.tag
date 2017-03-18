<con-editor>
      <yield />

    <script type="text/es6">
        import './con-string-field.tag';
        import './con-combobox-field.tag';
        import './con-editor-button.tag';
        import { LOAD_EDITOR_DATA, SHOW_EDITOR_DATA, SAVE_EDITOR_DATA, SAVE_EDITOR_ERROR } from './con-editor-actions.js';
        this.mixin('redux');

        this.fields = [];
        this.editorDataId = 0;

        this._updateData = (buttonCallback) => {
          let data = { id: this.editorDataId };
          this.fields.forEach( field => {
            field.save(data);
          });
          buttonCallback(data);
        }

        this.on('mount', () => {
          this.addReducer('editor', this.createReducer({},
            {
              [LOAD_EDITOR_DATA](state = initialState, action, slicedState) {
                  return {
                    [action.editorName]: {
                      loading: true
                    }
                  }
                },
              [SHOW_EDITOR_DATA](state = initialState, action, slicedState) {
                  return {
                    [action.editorName]: {
                      loading: false,
                      data: action.data
                    }
                  }
                },
              [SAVE_EDITOR_DATA](state = initialState, action, slicedState) {
                  return {
                    [action.editorName]: {
                      error: false,
                      saving: true
                    }
                  }
                },
              [SAVE_EDITOR_ERROR](state = initialState, action, slicedState) {
                  return {
                    [action.editorName]: {
                      error: true,
                      saving: false,
                      data: action.data
                    }
                  }
                },
            }));
           });

        this.addSubscriber( (state) => {
          let editorData = state['editor'][this.opts.name];
          if (editorData) {
            if (editorData.data && editorData.data.id) {
              this.editorDataId = editorData.data.id;
            }
          this.fields.forEach(field => {
              field.updateState(editorData);
           });
          this.update();
          }
        });

        this.addFieldDescription = field => {
          this.fields.push(field);
        }
    </script>
</con-editor>
