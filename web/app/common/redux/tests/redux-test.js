import * as riot from 'riot';
import 'chai';
import 'chai-jq';
import 'jasmine-jquery';
var expect = chai.expect;
jasmine.getFixtures().fixturesPath = 'base/app';

import './redux-test.tag';
import './redux-test-reducer.tag';
import './../redux-reducer.tag';
import { testRedux } from './redux-actions.js';
import { ReduxMixin } from './../redux-mixin.js';

describe('redux', () => {
    var redux;

    beforeEach(() => {
      loadFixtures('common/redux/tests/redux-test.html');
      redux = new ReduxMixin();
      riot.mixin('redux', redux);
      riot.mount('redux-test');
      redux.createStore();
    });

    describe('if the event redux-test is dispatched with data', () => {
        beforeEach(() => {
          redux.dispatch(testRedux('Test'));
        });

        it('set the test data to the state', () => {
            expect(redux.getState()['redux-test'].data).to.equal('Test');
         });
    });
});
