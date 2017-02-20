import * as riot from 'riot';
import 'chai';
import 'jasmine-jquery';
var expect = chai.expect;
jasmine.getFixtures().fixturesPath = 'base/app/common/section';

import './section-manager.tag';
import './section-reducer.tag';
import '../redux/redux-reducer.tag';
import { showSection, hideSection} from './section-actions.js';
import { ReduxMixin } from '../redux/redux-mixin.js';


describe('section-manager with configured groups', () => {
    var redux;

    beforeEach(() => {
      loadFixtures('section-manager-group-test.html');
      redux = new ReduxMixin();
      riot.mixin('redux', redux);
      riot.mount('*');
      redux.createStore();
    });

    describe('if the event showSection [s1,s3,s5] dispatched ', () => {
        beforeEach(() => { redux.dispatch(showSection(['s1','s3','s5'])); });

        it('should show section s1', () => {
            expect(document.querySelector('#visible1').textContent)
                .to.equal('Test1');
         });

        it('should show section s3', () => {
            expect(document.querySelector('#visible3').textContent)
               .to.equal('Test3');

        });

        it('should show section s5', () => {
            expect(document.querySelector('#visible5').textContent)
                .to.equal('Test5');
         });
    });
    describe('if the event showSection [s1], [s3] and [s5] dispatched ', () => {
        beforeEach(() => {
          redux.dispatch(showSection(['s1']));
          redux.dispatch(showSection(['s3']));
          redux.dispatch(showSection(['s5']));
          });

        it('should show section s1', () => {
            expect(document.querySelector('#visible1').textContent)
                .to.equal('Test1');
         });

        it('shouldn\'t show section s3', () => {
            expect(document.querySelector('#visible3')).to.equal(null);
        });

        it('should show section s5', () => {
            expect(document.querySelector('#visible5').textContent)
                .to.equal('Test5');
         });
    });
});
