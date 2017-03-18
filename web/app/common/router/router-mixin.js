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
          this.redux.dispatch(newRouteSet(
            routeEntry,
            route.query(),
            args
          ));
          this.routes[routeEntry].controller[this.routes[routeEntry].callbackFunction](args, route.query());
        });
      });
    route.start(true);

    this.redux.addSubscriber((state) => {
      if (! state['router'].IGNORE_URL_LINE) {
        route(state['router'].route)
      }
    });
  }

  addRoute(route, callbackFunction, controller, func = this._defaultFunction) {
    this.routes[route] ={
      route: route,
      callbackFunction: callbackFunction,
      controller: controller,
      func: func
    };
  }

  _defaultFunction(managerName, sections) {
  }

  getRoutes() {
    return this.routes;
  }

  routeTo(newRoute) {
    route(newRoute);
  }

  dumpRoutes() {
    console.log(this.routes);
  }
 }