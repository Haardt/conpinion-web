import * as riot from 'riot';
import 'chai';
import 'chai-jq';
import 'jasmine-jquery';
var expect = chai.expect;
jasmine.getFixtures().fixturesPath = 'base/app';

import './../section-manager.tag';
import './../section-reducer.tag';
import '../../redux/redux-reducer.tag';
import { showSection, hideSection } from './../section-actions.js';
import { ReduxMixin } from '../../redux/redux-mixin.js';


describe('section-manager', () => {
    var redux;

    beforeEach(() => {
      loadFixtures('common/section/tests/section-manager-section-test.html');
      redux = new ReduxMixin();
      riot.mixin('redux', redux);
      riot.mount('*');
      redux.createStore();
    });

    describe('if the event showSection s1 dispatched ', () => {
        beforeEach(() => { redux.dispatch(showSection(['s1'])); });

        it('should show section s1', () => {

            expect(document.querySelector('#visible1').textContent)
                .to.equal('Test1');
         });

        it('shouldn\'t show section s2', () => {
            expect(document.querySelector('[name="s2"] > div')).to.be.$hidden;
        });
    });

    describe('if the event showSection [s1,s2] dispatched ', () => {
        beforeEach(() => { redux.dispatch(showSection(['s1','s2'])); });

        it('should show section s1', () => {

            expect(document.querySelector('#visible1').textContent)
                .to.equal('Test1');
         });

        it('should show section s2', () => {
            expect(document.querySelector('#visible2').textContent)
              .to.equal('Test2');
        });
    });

    describe('if the event showSection [s1] and [s2] dispatched ', () => {
        beforeEach(() => {
          redux.dispatch(showSection(['s1']));
          redux.dispatch(showSection(['s2']));
         });

        it('should show section s1', () => {
            expect(document.querySelector('#visible1').textContent)
                .to.equal('Test1');
         });

        it('should show section s2', () => {
            expect(document.querySelector('#visible2').textContent)
              .to.equal('Test2');
        });
    });

    describe('if the event showSection [s1] and then [s2] is dispatched ', () => {
        beforeEach(() => {
          redux.dispatch(showSection(['s1']));
          redux.dispatch(showSection(['s2']));
         });

        it('should only have the last section in the change property', () => {
            expect(redux.getState()['section-manager'].added[0])
                .to.equal('s2');
         });
    });

    describe('if the event showSection [s1][s2] and then hide [s1][s2] is dispatched ', () => {
        beforeEach(() => {
          redux.dispatch(showSection(['s2']));
          redux.dispatch(showSection(['s1']));
          redux.dispatch(hideSection(['s2']));
          redux.dispatch(hideSection(['s1']));
         });

        it('should have no active sections', () => {
            expect(redux.getState()['section-manager'].sections)
                .to.be.empty;
         });
    });

        describe('if the event hideSection [s1] is dispatched ', () => {
            beforeEach(() => {
              redux.dispatch(showSection(['s1']));
              redux.dispatch(showSection(['s2']));
              redux.dispatch(hideSection(['s1']));
             });

            it('should hide section s1', () => {
               expect(document.querySelector('[name="s1"] > div')).to.be.$hidden;
             });
        });
        describe('if the event hideSection [s1] and then [s2] is dispatched ', () => {
            beforeEach(() => {
              redux.dispatch(showSection(['s1']));
              redux.dispatch(showSection(['s2']));
              redux.dispatch(hideSection(['s1']));
              redux.dispatch(hideSection(['s2']));
             });

            it('should hide section s1', () => {
               expect(document.querySelector('[name="s1"] > div')).to.be.$hidden;
             });

            it('should hide section s2', () => {
                expect(document.querySelector('[name="s2"] > div')).to.be.$hidden;
             });
        });

        describe('if the event hideSection [s1,s2] is dispatched ', () => {
            beforeEach(() => {
              redux.dispatch(showSection(['s1','s2']));
              redux.dispatch(hideSection(['s1','s2']));
             });

            it('should hide section s1', () => {
               expect(document.querySelector('[name="s1"] > div')).to.be.$hidden;
             });

            it('should hide section s2', () => {
               expect(document.querySelector('[name="s2"] > div')).to.be.$hidden;
             });
        });
});
