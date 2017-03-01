export const SHOW_VIEW = 'SHOW_VIEW';

export function showView(view) {
  return {
    type: SHOW_VIEW,
    view: view
  }
};
