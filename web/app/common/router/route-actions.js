
export const SHOW_SECTION = 'NEW_ROUTE';

export function newRoute(route) {
  return {
    type: NEW_ROUTE,
    route: route
    data: {}
  }
};
