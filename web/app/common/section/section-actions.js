
export const SHOW_SECTION = 'SHOW_SECTION';
export const HIDE_SECTION = 'HIDE_SECTION';

export function showSection(section) {
  return {
    type: SHOW_SECTION,
    section: section
  }
};

export function hideSection(section) {
  return {
    type: HIDE_SECTION,
    section: section
  }
};