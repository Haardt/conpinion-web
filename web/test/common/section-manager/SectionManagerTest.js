var riot = require("riot");
var chai = require('chai');
require('jasmine-jquery');
var expect = chai.expect;
jasmine.getFixtures().fixturesPath = 'base/test/common/section-manager';

require("../../../public/app/common/section/section-manager");

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
