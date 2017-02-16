import * as riot from 'riot';
import 'chai';
import 'jasmine-jquery';
var expect = chai.expect;
jasmine.getFixtures().fixturesPath = 'base/app/common/section';

import './section-manager.tag';
import './section-reducer.tag';
import '../redux/redux-reducer.tag';
import { SHOW_SECTION, showSection} from './section-actions.js';
import { ReduxMixin } from '../redux/redux-mixin.js';


describe('section-manager', () => {
    var redux;

    beforeEach(() => {
      loadFixtures('section-manager-test.html');
      redux = new ReduxMixin();
      riot.mixin('redux', redux);
      riot.mount('*');
      redux.createStore();
    });

    describe('section-manager', () => {
       // beforeEach(() => { redux.dispatch(showSection('s1')); });

        it('should show section s1', function () {

            expect(document.querySelector('#visible1').textContent)
                .to.equal('Test1');
         });

        it('shouldt show section s2', function () {
            expect(document.querySelector('#visible2')).to.equal(null);
        });
    });
});
