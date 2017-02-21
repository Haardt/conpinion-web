<route-definitions>
    <yield></yield>
    <script type="text/es6">
        import './route-entry.tag';

        this.mixin('router');

        this.on('mount', () => {
          let routes = this.tags['route-entry'];
          console.log("Routedefs:", routes);
          if (!Array.isArray(routes)) {
            routes = [routes];
          }
          routes.forEach( (routeEntry) => {
            let sections = routes.opts.section.replace(/\'/g,"\""));
            this.addRoute(routes.opts.route, sections);
          });
        });
  </script>
</route-definitions>
