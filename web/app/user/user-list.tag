<user-list>
  <con-table ref='users'>
    <yield to="columns">
      <con-column key="firstName" label="firstName" tag="con-string-column"/>
      <con-column key="lastName" label="lastName" tag="con-input-column"/>
    </yield>
    <yield to="buttons">
      <con-table-button label='Edit' function='edit' />
    </yield>
  </con-table>

  <script type="text/es6">
    import './../common/table/con-table.tag';
    import { newRoute } from './../common/router/route-actions.js'

    this.mixin('redux');

    this.edit = id => {
        this.dispatch(newRoute('/users/'+id));
    }

    this.on('mount', () => {
    });
  </script>
</user-list>