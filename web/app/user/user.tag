<user>
  <con-view name="user">
    <section-manager>
      <section-group>
        <section-content name="user-list">
          <user-list name="users"></user-list>
        </section-content>
        <section-content name="user-editor">
          <user-editor name="user"></user-editor>
        </section-content>
      </section-group>
    </section-manager>
  </con-view>

  <route-definitions>
    <route-entry route="/users/*" function='showUser'/>
    <route-entry route="/users" function='showUsers' />
  </route-definitions>

  <style>
  </style>

  <script type="text/es6">
    import './user-list.tag';
    import './user-editor.tag';
    import { showView } from '.././common/app/view-actions.js'
    import { showSection } from '.././common/section/section-actions.js'
    import { loadTableData } from '.././common/table/con-table-actions.js'
    import { loadEditorData } from '.././common/editor/con-editor-actions.js'

    this.mixin('redux');

    this.on('mount', () => {
    });

    this.showUsers = (args) => {
      this.dispatch(showView('user'));
      this.dispatch(showSection(['user-list']));
      this.dispatch(loadTableData('users', '/users'));
    }

    this.showUser = (args) => {
      this.dispatch(showView('user'));
      this.dispatch(showSection(['user-editor']));
      this.dispatch(loadEditorData('user', '/users/123'));
    }


  </script>
</user>
