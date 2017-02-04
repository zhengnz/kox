BaseModel = require './base'
template = require '../tpl/icon.html'

class viewModel extends BaseModel
  constructor: (params) ->
    super params
    config = ko.utils.extend {
      search: '&#xe660;'
      toggle: '&#xe940;'
      'toggle-filled': '&#xe8c6;'
      locked: '&#xe81e;'
      unlocked: '&#xe949;'
    }, global.koxIconConfig or {}

    @type = ko.pureComputed ->
      config[ko.unwrap params.type]

    @cls = ko.pureComputed ->
      cls = 'iconfont ko-icon'

      size = ko.unwrap params.size or null
      if size?
        cls = "#{cls} ko-#{size}"

      color = ko.unwrap params.color or null
      if color?
        cls = "#{cls} ko-#{color}"

      cls

    @disposes = @disposes.concat [@type, @cls]

ko.components.register 'ko-icon', {
  viewModel:
    createViewModel: (params, componentInfo) ->
      new viewModel params
  template: template
}