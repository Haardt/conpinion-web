<con-app>
  <yield></yield>

  <style>

  </style>

  <script type="text/es6">
    import '../redux/redux-reducer.tag';
    import '../redux/redux-subscriber.tag';
    import '../router/route-definitions.tag';
    import '../router/route-reducer.tag';
    import '../section/section-manager.tag';
    import '../section/section-reducer.tag';
    import '../menu/top-menu.tag';
    import '../view/con-view.tag';
    import ConAppReducer from './con-app-reducer.js';

    this.mixin('redux');

    this.views = [];

    this.on('mount', () => {
      let conAppReducer = new ConAppReducer();
      this.addReducer(conAppReducer.name(), this.createReducer(conAppReducer.initState(),
        conAppReducer.reducer(), (state) => state));
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
