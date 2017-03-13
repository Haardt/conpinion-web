<user-list>
  <con-table name="users" ref='users'>
    <con-column key="firstName" label="firstName" tag="con-string-column"/>
    <con-column key="lastName" label="lastName" tag="con-input-column"/>
  </con-table>

  <script type="text/es6">
    import './../common/table/con-table.tag';
    import { newRoute } from './../common/router/route-actions.js'

    this.mixin('redux');

    this.on('mount', () => {
      this.refs.users.editCallback((id) => {
        console.log('Edit callback:', id);
        this.dispatch(newRoute('/users/'+id));
      });

    });

  </script>


</user-list>