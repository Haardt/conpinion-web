
export const SHOW_SECTION = 'SHOW_SECTION';
export const HIDE_SECTION = 'HIDE_SECTION';

export function showSection(sections) {
  return {
    type: SHOW_SECTION,
    sections: sections
  }
};

export function hideSection(sections) {
  return {
    type: HIDE_SECTION,
    sections: sections
  }
};