<user-editor>
  <con-editor name="user">
    <con-string-field key="firstName" label="firstName" />
    <con-combobox-field key="lastName" label="lastName" />
    <con-editor-button label="save" function='save'/>
    <con-editor-button label="cancel" function='cancel'/>

  </con-table>

  <script type="text/es6">
    import './../common/editor/con-editor.tag';
    import { saveEditorData } from './../common/editor/con-editor-actions.js';
    import { newRoute } from './../common/router/route-actions.js'

    this.mixin('redux');

    this.save = (data) => {
      this.dispatch(saveEditorData('user','/users/', data));
    };

    this.cancel = (data) => {
      this.dispatch(newRoute('/users/'));
    };

  </script>
</user-editor>