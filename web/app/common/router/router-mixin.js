import route from 'riot-route';

let instance = null;

export class RouterMixin {

  constructor(redux) {
    if (instance){
      return instance;
    }
    this.redux = redux;
    this.routes = [];
    instance = this;
  }

  setupRouter() {
    this.routes.forEach((routeDef) => {
      route(routeDef.route, (collection, id, action) => {
          console.log("Enter route:", routeDef.route);
        });
      });
    route.start(true);

    this.redux.addSubscriber((state) => {
      route(state['router'].route)
    });
  }

  addRoute(route, sections, func = this._defaultFunction) {
    this.routes.push({
      route: route,
      sections: sections,
      func: func
    });
  }

  _defaultFunction(managerName, sections) {
  }

  dumpRoutes() {
    console.log(this.routes);
  }
 }