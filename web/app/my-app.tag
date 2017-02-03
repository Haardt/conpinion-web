<my-app>
    <top-menu>
        <top-menu-item>Menu-Item-1</top-menu-item>
        <top-menu-item active='true'>Menu-Item-3</top-menu-item>
    </top-menu>
    
    <section-manager>
        <site-section active="true">
            <div class="ui center aligned header">
                Section-Test123456
            </div>
        </site-section>
    </section-manager>

    <my-test> </my-test>
    <script type="text/es6">
      import 'riot-hot-reload'
      import './my-test.tag';
      import './common/menu/top-menu.tag';
      import './common/menu/top-menu-item.tag';
      console.log("app");
    </script>
</my-app>

riot.mount('*');