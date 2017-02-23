import route from 'riot-route';
import { newRouteSet } from './route-actions.js'

let instance = null;

export default class RouterMixin {

  constructor(redux) {
    if (instance){
      return instance;
    }
    this.redux = redux;
    this.routes = {};
    instance = this;
  }

  static instance() {
    return instance;
  }

  setupRouter() {
    Object.keys(this.routes).forEach((routeEntry) => {
      route(routeEntry, (...args) => {
          console.log('Enter route:', this.routes[routeEntry]);
          this.redux.dispatch(newRouteSet(
            routeEntry,
            this.routes[routeEntry].view,
            this.routes[routeEntry].sections,
            route.query(),
            args
          ));
        });
      });
    route.start(true);

    this.redux.addSubscriber((state) => {
      if (! state['router'].IGNORE_URL_LINE) {
        route(state['router'].route)
      }
    });
  }

  addRoute(route, view, sections, func = this._defaultFunction) {
    this.routes[route] ={
      route: route,
      view: view,
      sections: sections,
      func: func
    };
  }

  _defaultFunction(managerName, sections) {
  }

  getRoutes() {
    return this.routes;
  }

  dumpRoutes() {
    console.log(this.routes);
  }
 }