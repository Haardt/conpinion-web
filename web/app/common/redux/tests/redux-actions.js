export const TEST_REDUX = 'TEST_REDUX';

export function testRedux(data) {
  return {
    type: TEST_REDUX,
    data: data
  }
};
