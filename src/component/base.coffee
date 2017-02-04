class BaseModel
  constructor: (params) ->
    @disposes = []

  dispose: ->
    ko.utils.arrayForEach @disposes, (obj) ->
      obj.dispose()

module.exports = BaseModel