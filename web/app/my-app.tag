<my-app>
  <con-app name="testing-app" class="ui grid">
    <div class="sixteen wide column">
      <top-menu>
          <top-menu-item route='/users'>Users</top-menu-item>
          <top-menu-item route='/users/123' active='true'>User-123</top-menu-item>
      </top-menu>
    </div>
    <div class="sixteen wide column">
      <user />
    </div>

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
import "./../public/app/semantic/components/reset.css";
import "./../public/app/semantic/components/grid.css";

import RouterMixin from './common/router/router-mixin.js';
import { ReduxMixin } from './common/redux/redux-mixin.js';
import { newRoute } from './common/router/route-actions.js'

let reduxMixin = new ReduxMixin();
let routerMixin = new RouterMixin(reduxMixin);

riot.mixin('redux', reduxMixin);
riot.mixin('router', routerMixin);
riot.mount('*');
routerMixin.setupRouter();
reduxMixin.createStore();

reduxMixin.dispatch(newRoute('/users'));

//reduxMixin.dumpState();
