BaseModel = require './base'
template = require '../tpl/loader.html'

class viewModel extends BaseModel
  constructor: (params) ->
    super params
    @visible = ko.pureComputed ->
      ko.unwrap params.visible or true
    @cls = ko.pureComputed ->
      cls = 'ko-loader'

      size = ko.unwrap params.size or null
      if size?
        cls = "#{cls} ko-#{size}"

      reverse = ko.unwrap params.reverse or false
      if reverse
        cls = "#{cls} ko-reverse"

      cls

    @disposes = @disposes.concat [@visible, @cls]

ko.components.register 'ko-loader', {
  viewModel:
    createViewModel: (params, componentInfo) ->
      new viewModel params
  template: template
}