expect = require("chai").expect
sinon = require("sinon")

Reporter = require("../../../src/reporters/xhr_reporter")

MockXhr = ->
MockXhr.prototype = {
  open: ->
  send: ->
  setRequestHeader: ->
}

describe "XhrReporter", ->
  oldXhr = null
  beforeEach ->
    oldXhr = global.XMLHttpRequest
    global.XMLHttpRequest = MockXhr
  afterEach ->
    global.XMLHttpRequest = oldXhr

  describe "report", ->
    it "opens async POST to url", ->
      spy = sinon.spy(global.XMLHttpRequest.prototype, 'open')
      fn = Reporter("")
      fn({}, {projectId: '[project_id]', projectKey: '[project_key]'})
      expect(spy).to.have.been.calledWith("POST", "https://api.airbrake.io/api/v3/projects/[project_id]/notices?key=[project_key]", true)
