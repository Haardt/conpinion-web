<my-app>
  <con-app name="testing-app">
    <top-menu>
        <top-menu-item>Menu-Item-1</top-menu-item>
        <top-menu-item active='true'>Menu-Item-3</top-menu-item>
    </top-menu>


    <user />

    <route-definitions>
      <route-entry route="/profile/*" section="['s2','s4']" />
    </route-definitions>

    <redux-reducer>
      <section-reducer/>
      <route-reducer/>
    </redux-reducer>
  <con-app>
  <script type="text/es6">
    import 'riot-hot-reload';
    import './common/app/con-app.tag';
    import './user/user.tag';

  </script>
</my-app>

import RouterMixin from './common/router/router-mixin.js';
import { ReduxMixin } from './common/redux/redux-mixin.js';
import { showSection } from './common/section/section-actions.js'
import { newRoute } from './common/router/route-actions.js'

let reduxMixin = new ReduxMixin();
let routerMixin = new RouterMixin(reduxMixin);

riot.mixin('redux', reduxMixin);
riot.mixin('router', routerMixin);
riot.mount('*');
routerMixin.setupRouter();
reduxMixin.createStore();

reduxMixin.dispatch(showSection(['s2']));
reduxMixin.dispatch(newRoute('/users/20'));
reduxMixin.dumpState();
