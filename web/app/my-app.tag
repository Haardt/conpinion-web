<my-app>
    <con-app name="testing-app">
        <div class="ui main text container">
            <h1 class="ui header">massenhaft@twitter</h1>
            <p>Redux, Riotjs, Vertx, EventSourcing -> Microservice tests</p>
        </div>
        <top-menu menu-title="conpinion-web">
            <top-menu-item route='/users'>Users</top-menu-item>
            <top-menu-item route='/users/123' active='true'>User-123</top-menu-item>
        </top-menu>
        <div class="ui text container">
            <user/>
        </div>

        <my-footer />

        <redux-reducer>
            <section-reducer/>
            <route-reducer/>
        </redux-reducer>
    </con-app>

    <style>
        body {
            background-color: #FFFFFF;
        }

        .main.container {
            margin-top: 2em;
        }

        .main.menu {
            margin-top: 4em;
            border-radius: 0;
            border: none;
            box-shadow: none;
            transition: box-shadow 0.5s ease,
            padding 0.5s ease;
        }

        .main.menu .item img.logo {
            margin-right: 1.5em;
        }

        .overlay {
            float: left;
            margin: 0em 3em 1em 0em;
        }

        .overlay .menu {
            position: relative;
            left: 0;
            transition: left 0.5s ease;
        }

        .main.menu.fixed {
            background-color: #FFFFFF;
            border: 1px solid #DDD;
            box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.2);
        }

        .overlay.fixed .menu {
            left: 800px;
        }

        .text.container .left.floated.image {
            margin: 2em 2em 2em -4em;
        }

        .text.container .right.floated.image {
            margin: 2em -4em 2em 2em;
        }

        .ui.footer.segment {
            margin: 5em 0em 0em;
            padding: 5em 0em;
        }
    </style>
    <script type="es6">
        //import 'riot-hot-reload';
        import './common/app/con-app.tag';
        import './user/user.tag';

    </script>
</my-app>

import "./../public/app/semantic/components/reset.css";
import "./../public/app/semantic/components/grid.css";
import "./../public/app/semantic/components/container.css";
import "./../public/app/semantic/components/grid.css";
import "./../public/app/semantic/components/header.css";
import "./../public/app/semantic/components/image.css";
import "./../public/app/semantic/components/divider.css";
import "./../public/app/semantic/components/list.css";
import "./../public/app/semantic/components/segment.css";

import './my-footer.tag';
import RouterMixin from './common/router/router-mixin.js';
import { ReduxMixin } from './common/redux/redux-mixin.js';
import { newRoute } from './common/router/route-actions.js'

var reduxMixin = new ReduxMixin();
var routerMixin = new RouterMixin(reduxMixin);

riot.mixin('redux', reduxMixin);
riot.mixin('router', routerMixin);
riot.mount('*');
routerMixin.setupRouter();
reduxMixin.createStore();

reduxMixin.dispatch(newRoute('/users'));

//reduxMixin.dumpState();
