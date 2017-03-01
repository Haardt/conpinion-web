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
          let domainController = this.parent;
          routes.forEach(routeEntry => {
            this.addRoute(routeEntry.opts.route, routeEntry.opts.function, domainController);
          });
        });
  </script>
</route-definitions>
