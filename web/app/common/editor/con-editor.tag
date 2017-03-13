<con-editor>
    <form>
      <yield />
    </form>

    <script type="text/es6">
        import './con-string-field.tag';
        import { LOAD_EDITOR_DATA, SHOW_EDITOR_DATA } from './con-editor-actions.js';
        this.mixin('redux');

        this.fields = {};

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
            }));
           });

        this.addSubscriber( (state) => {
          let editorData = state['editor'][this.opts.name];
          if (editorData) {
            if (editorData.loading == true) {
            }
            if (editorData.loading == false) {
              if (editorData.data) {
                let keys = Object.keys(editorData.data);
                keys.forEach((key) => {
                  this.fields[key].tag.updateValue(editorData.data[key]);
                  this.fields[key].tag.update();
                 }
                );
              }
            }
          }
          this.update();
        });

        this.addFieldDescription = field => {
          this.fields[field.opts.key] =
            {
              tag: field
            };
        }
    </script>
</con-editor>
