import * as riot from 'riot';
import 'chai';
import 'jasmine-jquery';
var expect = chai.expect;
jasmine.getFixtures().fixturesPath = 'base/app/common/section';

import './site-manager.tag';
import {ReduxMixin} from '../redux/redux-mixin.js';

describe('site-manager', () => {
    describe('site-section', () => {

        describe('with the active attribute set to true', () => {

            loadFixtures('section-manager-test.html');
            riot.mixin('redux', new ReduxMixin())
            riot.mount('*');

            it('should be visible', () => {
                expect(document.querySelector('#visible').textContent)
                        .to.equal('Test1');
            });
        });

        describe('with the active attribute set to false', () => {

            loadFixtures('section-manager-test.html');
            riot.mixin('redux', new ReduxMixin())
            riot.mount('*');

            it('should be invisible', () => {
                expect(document.querySelector('#invisible'))
                        .to.be.equal(null);
            });
        });
    });
});
