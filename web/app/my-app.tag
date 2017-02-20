<my-app>
    <top-menu>
        <top-menu-item>Menu-Item-1</top-menu-item>
        <top-menu-item active='true'>Menu-Item-3</top-menu-item>
    </top-menu>

    <section-manager section="s1">
        <section-group hide-others='true' only-on-members='false'>
          <section-content name="s1">
              <div class="ui center aligned header">
                <p>S1</p>
              </div>
          </section-content>
          <section-content name="s2">
              <div class="ui center aligned header">
                <p>S2</p>
              </div>
          </section-content>
        </section-group>
        <section-group hide-others='true'>
          <section-content name="s3">
              <div class="ui center aligned header">
                <p>S3</p>
              </div>
          </section-content>
          <section-content name="s4">
              <div class="ui center aligned header">
                <p>S4</p>
              </div>
          </section-content>
        </section-group>
    </section-manager>


    <route-definitions>
      <route-entry route="/tests/*" hideManager/>
    </route-definitions>


    <redux-reducer>
      <section-reducer/>
    </redux-reducer>

    <script type="text/es6">
      import 'riot-hot-reload';
      import './common/redux/redux-reducer.tag';
      import './common/redux/redux-subscriber.tag';
      import './common/router/route-definitions.tag';
      import './common/section/section-manager.tag';
      import './common/section/section-reducer.tag';
      import './common/menu/top-menu.tag';
    </script>
</my-app>

import {RouterMixin} from './common/router/router-mixin.js';
import {ReduxMixin} from './common/redux/redux-mixin.js';
import { SHOW_SECTION, showSection } from './common/section/section-actions.js'

let reduxMixin = new ReduxMixin();
let routerMixin = new RouterMixin(reduxMixin);

riot.mixin('redux', reduxMixin);
riot.mixin('router', routerMixin);
riot.mount('*');
routerMixin.setupRouter();
reduxMixin.createStore();
reduxMixin.dispatch(showSection(['s2']));
reduxMixin.dispatch(showSection(['s1']));
reduxMixin.dispatch(showSection(['s2']));
reduxMixin.dispatch(showSection(['s4']));
reduxMixin.dumpState();
