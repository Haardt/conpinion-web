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
              console.log("MRoute:", routeEntry.opts.route);
              console.log("MRoute:", JSON.parse(routeEntry.opts.section));
            });
          } else {
            this.addRoute(routes.opts.route,'', '');
              console.log("MRoute:", routes.opts.section.replace(/\'/g,"\""));
              console.log("MRoute:", JSON.parse(routes.opts.section.replace(/\'/g,"\"")));

            console.log("Route:", routes.opts.route);
          }
        });
  </script>
</route-definitions>
