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

        this._updateData = (buttonCallback) => {
            buttonCallback(this.loadingId, this.editorData.data);
        }

        this.on('mount', () => {
        });

        this.addSubscriber((state) => {
            let editorName = this.opts.name;
            let editor = state.editor;
            if (!editor[editorName]) {
                return;
            }
            this.editorData = editor[editorName][editor[editorName].loadingId];
            this.loadingId = editor[editorName].loadingId;
        });

        this.addFieldDescription = field => {
            this.fields.push(field);
            field.setEditorName(this.opts.name);
        }
    </script>
</con-editor>
