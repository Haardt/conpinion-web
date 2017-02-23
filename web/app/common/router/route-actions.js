export const NEW_ROUTE = 'NEW_ROUTE';
export const NEW_ROUTE_SET = 'NEW_ROUTE_SET';

export function newRoute(route) {
  return {
    type: NEW_ROUTE,
    route: route,
    data: {}
  }
};

export function routingFinished(route, sections, query, params, data) {
  return {
    type: NEW_ROUTE_SET,
    route: route,
    sections: sections,
    query: query,
    params: params,
    data: data
  }
};
