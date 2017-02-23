<user>
  <con-view name="user">
    <section-manager>
      <section-group>
        <section-content name="user-list">
          user-list
        </section-content>
        <section-content name="user-editor">
          user-editor
        </section-content>
      </section-group>
    </section-manager>
  </con-view>

  <route-definitions>
    <route-entry route="/users" view="user" section="['user-list']"/>
    <route-entry route="/users/*" view="user" section="['user-editor']"/>
  </route-definitions>

  <style>
  </style>

  <script type="text/es6">

  </script>
</user>
