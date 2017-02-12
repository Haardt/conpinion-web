<my-app>
    <top-menu>
        <top-menu-item>Menu-Item-1</top-menu-item>
        <top-menu-item active='true'>Menu-Item-3</top-menu-item>
    </top-menu>

    <site-manager section="s1">
        <site-section name="s1">
            <div class="ui center aligned header">
              <p>S1</p>
            </div>
        </site-section>
        <site-section name="s2">
            <div class="ui center aligned header">
              <p>S2</p>
            </div>
        </site-section>
    </site-manager>


    <redux-reducer>
      <site-reducer/>
    </redux-reducer>

    <script type="text/es6">
      import 'riot-hot-reload';
      import './common/redux/redux-reducer.tag';
      import './common/redux/redux-subscriber.tag';
      import './common/redux/redux-config.tag';
      import './common/section/site-manager.tag';
      import './common/section/site-reducer.tag';
      import './common/menu/top-menu.tag';
    </script>
</my-app>

import {ReduxMixin} from './common/redux/redux-mixin.js';

let reduxMixin = new ReduxMixin();

riot.mixin('redux', reduxMixin);
riot.mount('*');
reduxMixin.createStore();
reduxMixin.dispatch({type:'SHOW_SECTION', section:['s1']});
//reduxMixin.dispatch({type:'SHOW_SECTION', section:['s2']});
//reduxMixin.dispatch({type:'SHOW_SECTION', section:['s1','s2']});
reduxMixin.dumpState();
