export const NEW_ROUTE = 'NEW_ROUTE';
export const ROUTING_FINISHED = 'ROUTING_FINISHED';

export function newRoute(route) {
  return {
    type: NEW_ROUTE,
    route: route,
    data: {}
  }
};

export function routingFinished(route, sections, query, params, data) {
  return {
    type: ROUTING_FINISHED,
    route: route,
    sections: sections,
    query: query,
    params: params,
    data: data
  }
};
