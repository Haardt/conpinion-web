<user-list>
  <con-table name="users">
    <con-column key="firstName" label="firstName" />
    <con-column key="lastName" label="lastName" />
  </con-table>

  <script type="text/es6">
    import './../common/table/con-table.tag';
    this.mixin('redux');

    this.addSubscriber((state) => {
      if (state['section-manager']) {
        console.log (state['section-manager']);
      }
    });
  </script>


</user-list>