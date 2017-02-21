import route from 'riot-route';

import { showSection, hideSection } from '../section/section-actions.js';

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
    console.log("Init router");

    this.routes.forEach( (routeDef) => {
      route(routeDef.route, (collection, id, action) => {
          console.log("Enter route:", routeDef.route);
        });
      });
    route('customers/267393/edit');
    route.start(true);
  }

  addRoute(route, sections, func = this._showSection) {
    this.routes.push({
      route: route,
      sections: sections,
      func: func
    });
  }

  _showSection(managerName, sections) {
    this.redux.showSection(sections)
  }

  dumpRoutes() {
    console.log(this.routes);
  }
 }