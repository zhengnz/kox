BaseModel = require './base'
template = require '../tpl/row.html'

class viewModel extends BaseModel
  constructor: (params, componentInfo) ->
    super params
    @data = {
      $context: params.data
      gutter: params.gutter or null
    }

    e = componentInfo.element.firstChild
    @disposes.push ko.computed =>
      gutter = ko.unwrap @data.gutter
      if gutter?
        px = "-#{Math.floor gutter / 2}px"
        e.style['margin-left'] = px
        e.style['margin-right'] = px
      else
        e.style['margin-left'] = 'auto'
        e.style['margin-right'] = 'auto'
    @visible = ko.pureComputed =>
      ko.unwrap params.visible ? true
    @disposes.push @visible

ko.components.register 'ko-row', {
  viewModel:
    createViewModel: (params, componentInfo) ->
      params.data = ko.dataFor componentInfo.element
      new viewModel params, componentInfo
  template: template
}