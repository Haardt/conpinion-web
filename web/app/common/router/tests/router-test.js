import * as riot from 'riot';
import 'chai';
import 'chai-jq';
import 'jasmine-jquery';
var expect = chai.expect;
jasmine.getFixtures().fixturesPath = 'base/app';

import RouterMixin from './../router-mixin.js';
import './route-test.tag';
import './../route-reducer.tag';
import './../route-definitions.tag';
import './../route-entry.tag';
import '../../redux/redux-reducer.tag';
import { newRoute } from './../route-actions.js';
import { ReduxMixin } from '../../redux/redux-mixin.js';

describe('router', () => {
    var redux;
    var router;
    var testTag

    beforeEach(() => {
      loadFixtures('common/router/tests/router-test.html');
      redux = new ReduxMixin();
      router = new RouterMixin(redux);
      riot.mixin('redux', redux);
      riot.mixin('router', router);
      testTag = riot.mount('test')[0];
      router.setupRouter();
      redux.createStore();
    });

    describe('if the event newRoute to /tests is dispatched ', () => {
        beforeEach(() => {
          redux.dispatch(newRoute('/ignore'));
          redux.dispatch(newRoute('/tests'));
        });

        it('should set the new route', () => {
            expect(redux.getState()['router'].route).to.equal('/tests');
         });

        it('should executed the callback test2', () => {
            expect(testTag.getTest2()).to.equal(true);
         });
    });

    describe('if the event newRoute to /tests/123 is dispatched ', () => {
        beforeEach(() => {
          redux.dispatch(newRoute('/ignore'));
          redux.dispatch(newRoute('/tests/123'));
        });

        it('should set the new route', () => {
            expect(redux.getState()['router'].route).to.equal('/tests/*');
         });

        it('should have 123 in the application state', () => {
            expect(redux.getState()['router'].params[0]).to.equal('123');
         });

        it('should executed the callback test2', () => {
            expect(testTag.getTest1()).to.equal(true);
         });
    });
});
