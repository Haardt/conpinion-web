<user-editor>
    <con-editor name={this.opts.name}>
        <con-string-field key="firstName" label="firstName"/>
        <con-combobox-field key="lastName" label="lastName"/>
        <con-editor-button label="save" function='save'/>
        <con-editor-button label="cancel" function='cancel'/>

    </con-editor>

    <script type="es6">
        import './../common/editor/con-editor.tag';
        import {saveEditorData} from './../common/editor/con-editor-actions.js';
        import {newRoute} from './../common/router/route-actions.js'

        this.mixin('redux');

        this.save = (editorId, data) => {
            console.log('Save:', data);
            this.dispatch(saveEditorData(this.opts.name, editorId, '/users/', data));
        };

        this.cancel = (editorId, data) => {
            this.dispatch(newRoute('/users/'));
        };

    </script>
</user-editor>