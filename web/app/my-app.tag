require('./bundle.css');
require('./common/section/section-manager');
require('./common/menu/top-menu');
require('./common/menu/top-menu-item');
require('./my-test');
require('./common/redux/redux-mixin');
require('./common/redux/redux-test');

<my-app>
    <top-menu>
        <top-menu-item>Menu-Item-1</top-menu-item>
        <top-menu-item active='true'>Menu-Item-3</top-menu-item>
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
        mixin('name');
        import * as test from './common/redux/redux-test';
        test.helloWorld();
        var hello: string = 'Hallo World';
        helloWorld();
        //var redux = new ReduxMixin();
        console.log(this.ReduxMixin);
//        console.log(ReduxMixin);
    </script>
</my-app>

riot.mount('*');