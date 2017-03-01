export const NEW_ROUTE = 'NEW_ROUTE';
export const NEW_ROUTE_SET = 'NEW_ROUTE_SET';

export function newRoute(route) {
  return {
    type: NEW_ROUTE,
    route: route,
    data: {}
  }
};

export function newRouteSet(route, view, sections, query, params) {
  return {
    type: NEW_ROUTE_SET,
    route: route,
    query: query,
    params: params
  }
};
