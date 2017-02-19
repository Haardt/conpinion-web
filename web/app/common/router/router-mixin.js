import route from 'riot-route';

let instance = null;

export class RouterMixin {

  constructor() {
    if (instance){
      return instance;
    }

    this.routes = {};
    instance = this;
  }

  init() {
    console.log("Init router");
    route( (collection, id, action) => {
      console.log("Route: ", collection);
    });
    route('customers/267393/edit');
    route.start(true);
  }

  addRoute(route) {
    this.routes[route] = '';
  }

  dumpRoutes() {
    console.log(this.routes);
  }
 }