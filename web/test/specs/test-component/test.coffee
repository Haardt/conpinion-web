
describe 'my awesome website', () ->
  it 'should do some chai assertions', () ->
    browser.url('/specs/test-component/test-component.html').getTitle().then (title) ->
      browser.getText('#test=test sample').then (text) ->
        console.log text
        text.should.equals "test sample"
        title.should.equals "TELCAT-UC simpleSBC"
