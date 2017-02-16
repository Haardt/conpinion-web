
export const SHOW_SECTION = 'SHOW_SECTION';

export function showSection(section) {
  return {
    type: SHOW_SECTION,
    section: [section]
  }
};