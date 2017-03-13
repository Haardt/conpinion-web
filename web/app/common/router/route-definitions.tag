<route-definitions>
    <yield></yield>
    <script type="text/es6">
        import './route-entry.tag';

        this.mixin('router');

        this.on('mount', () => {
          let routes = this.tags['route-entry'];
          if (!Array.isArray(routes)) {
            routes = [routes];
          }
          let controller = this.parent;
          routes.forEach(routeEntry => {
            this.addRoute(routeEntry.opts.route, routeEntry.opts.function, controller);
          });
        });
  </script>
</route-definitions>
