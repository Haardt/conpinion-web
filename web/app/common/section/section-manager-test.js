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


describe('section-manager shows s1 section', () => {
    it('should show section s1', function () {
        loadFixtures('section-manager-test.html');
        let redux = new ReduxMixin();
        riot.mixin('redux', redux);
        riot.mount('*');
        redux.createStore();
        redux.dispatch(showSection('s1'));

        expect(document.querySelector('#visible1').textContent)
                .to.equal('Test1');
    });
});

describe('section-manager shows s2 section', () => {

    it('should show section s2', function () {
        loadFixtures('section-manager-test.html');
        let redux = new ReduxMixin();
        riot.mixin('redux', redux);
        riot.mount('*');
        redux.createStore();
        redux.dispatch(showSection('s2'));

        expect(document.querySelector('#visible2').textContent)
                .to.equal('Test2');
    });
});
