import * as riot from 'riot';
import 'chai';
import 'jasmine-jquery';
var expect = chai.expect;
jasmine.getFixtures().fixturesPath = 'base/test/common/section-manager';

import '../../../app/common/section/section-manager.tag';

describe('section-manager', () => {
    describe('site-section', () => {

        describe('with the active attribute set to true', () => {

            loadFixtures('section-manager-test.html');
            riot.mount('*');

            it('should be visible', function () {
                expect(document.querySelector('#visible').textContent)
                        .to.equal('Test1');
            });
        });

        describe('with the active attribute set to false', () => {

            loadFixtures('section-manager-test.html');
            riot.mount('*');

            it('should be invisible', function () {
                expect(document.querySelector('#invisible'))
                        .to.be.equal(null);
            });
        });
    });
});
