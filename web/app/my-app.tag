<my-app>
  <con-app name="testing-app" class="ui grid">
    <div class="sixteen wide column">
      <top-menu>
          <top-menu-item>Menu-Item-1</top-menu-item>
          <top-menu-item active='true'>Menu-Item-3</top-menu-item>
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
import { showSection } from './common/section/section-actions.js'
import { showTable, showTableData } from './common/table/con-table-actions.js'
import { newRoute } from './common/router/route-actions.js'

let reduxMixin = new ReduxMixin();
let routerMixin = new RouterMixin(reduxMixin);

riot.mixin('redux', reduxMixin);
riot.mixin('router', routerMixin);
riot.mount('*');
routerMixin.setupRouter();
reduxMixin.createStore();

reduxMixin.dispatch(newRoute('/users'));
reduxMixin.dispatch(showTable('users', '/users'));
reduxMixin.dispatch(showTableData('users',
  {
    firstName:'Max',
    lastName: 'Mustermann'
  }));
reduxMixin.dumpState();
