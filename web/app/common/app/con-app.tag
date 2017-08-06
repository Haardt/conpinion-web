<con-app>
  <yield></yield>

  <style>

  </style>

  <script type="es6">
    //import 'jquery';
    import '../redux/redux-reducer.tag';
    import '../router/route-definitions.tag';
    import '../router/route-reducer.tag';
    import '../section/section-manager.tag';
    import '../section/section-reducer.tag';
    import '../menu/top-menu.tag';
    import './con-view.tag';
    import { tableMiddleware } from '../table/con-table-rest-middleware.js';
    import { editorMiddleware } from '../editor/con-editor-rest-middleware.js';
    import ConEditorReducer from '../editor/con-editor-reducer.js';
    import ConAppReducer from './con-app-reducer.js';

    this.mixin('redux');

    this.views = [];

    this.on('mount', () => {
      let conAppReducer = new ConAppReducer();
      let conEditorReducer = new ConEditorReducer();
      this.addMiddleware(tableMiddleware);
      this.addMiddleware(editorMiddleware);
      this.addReducer(conAppReducer.name(), this.createReducer(conAppReducer.initState(),
        conAppReducer.reducer(), (state) => state));
      this.addReducer(conEditorReducer.name(), this.createReducer(conEditorReducer.initState(),
        conEditorReducer.reducer(), (state) => state));
    });

    this.addSubscriber((state) => {
      this.views.forEach((view) => {
        if (state.views.view === view.opts.name) {
          view.show();
        }
        else {
          view.hide();
        }
      });
    });

    this.addView = (view) => {
      this.views.push(view);
    }

  </script>
</con-app>
