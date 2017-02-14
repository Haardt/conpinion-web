<my-app>
    <top-menu>
        <top-menu-item>Menu-Item-1</top-menu-item>
        <top-menu-item active='true'>Menu-Item-3</top-menu-item>
    </top-menu>

    <section-manager section="s1">
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
    </section-manager>


    <redux-reducer>
      <section-reducer/>
    </redux-reducer>

    <script type="text/es6">
      import 'riot-hot-reload';
      import './common/redux/redux-reducer.tag';
      import './common/redux/redux-subscriber.tag';
      import './common/redux/redux-config.tag';
      import './common/section/section-manager.tag';
      import './common/section/section-reducer.tag';
      import './common/menu/top-menu.tag';
    </script>
</my-app>

import {ReduxMixin} from './common/redux/redux-mixin.js';
import { SHOW_SECTION, showSection } from './common/section/section-actions.js'

let reduxMixin = new ReduxMixin();

riot.mixin('redux', reduxMixin);
riot.mount('*');
reduxMixin.createStore();
reduxMixin.dispatch(showSection('s2'));
reduxMixin.dispatch(showSection('s1'));
reduxMixin.dumpState();
