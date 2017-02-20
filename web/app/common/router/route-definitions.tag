<route-definitions>
    <yield></yield>
    <script type="text/es6">
        import './route-entry.tag';

        this.mixin('router');

        this.on('mount', () => {
          let routes = this.tags['route-entry'];
          console.log("Routedefs:", routes);
          if (Array.isArray(routes)) {
            routes.forEach( (routeEntry) => {
              console.log("MRoute:", routeEntry.route);
            });
          } else {
            this.addRoute(routes.opts.route,
              '', '');

            console.log("Route:", routes.opts.route);
          }
        });
  </script>
</route-definitions>
