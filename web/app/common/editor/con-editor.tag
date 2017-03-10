<con-editor>
    <yield />

    <form>
      <p each={ field in fields}>{field.label}<input name="{field.key}" value="{data[field.key]}"/></p>
    </form>

    <script type="text/es6">
        import './con-string-field.tag';
        import { LOAD_EDITOR_DATA, SHOW_EDITOR_DATA } from './con-editor-actions.js';
        this.mixin('redux');

        this.fields = [];
        this.data = {};

        this.on('mount', () => {
          this.addReducer('editor', this.createReducer({},
            {
              [LOAD_EDITOR_DATA](state = initialState, action, slicedState) {
                  return {
                    ["" + action.editorName]: {
                      loading: true
                    }
                  }
                },
                [SHOW_EDITOR_DATA](state = initialState, action, slicedState) {
                  return {
                    ["" + action.editorName]: {
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
                this.data = editorData.data;
              }
            }
          }
          this.update();
        });

        this.addField = field => {
          this.fields.push({key: field.opts.key, label: field.opts.label});
        }
    </script>
</con-editor>
