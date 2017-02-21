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
          routes.forEach(routeEntry => {
            let sections = routeEntry.opts.section.replace(/\'/g,"\"");
            this.addRoute(routeEntry.opts.route, sections);
          });
        });
  </script>
</route-definitions>
