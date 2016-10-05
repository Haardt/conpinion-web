require('./bundle.css');
require('./common/section/section-manager');
require('./common/menu/top-menu');
require('./common/menu/top-menu-item');
require('./my-test');

<my-app>
    <top-menu>
        <top-menu-item>Menu-Item-1</top-menu-item>
        <top-menu-item active='true'>Menu-Item-2</top-menu-item>
    </top-menu>
    
    <section-manager>
        <site-section active="true">
            <div class="ui center aligned header">
                Section-Test123
            </div>
        </site-ssection>
    </section-manager>

    <my-test>

    </my-test>
    <script type="text/typescript">
        var hello: string = 'Hallo2';
    </script>
</my-app>

riot.mount('*');