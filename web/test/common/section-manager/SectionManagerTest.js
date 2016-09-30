var riot = require("riot");
var chai = require('chai');
require('jasmine-jquery');
var expect = chai.expect;
jasmine.getFixtures().fixturesPath = 'base/test/common/section-manager';

require("../../../public/app/common/section/section-manager");

describe('karma-riot specs', function() {


  it('mounts hello tag', function() {
//    var html = document.createElement('section-manager');
//    document.body.appendChild(html);
    loadFixtures('section-manager-test.html');

    riot.mount('*');
    expect(document.querySelector('p').textContent)
            .to.equal('Test1');
  });

});
