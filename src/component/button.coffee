BaseModel = require './base'
btnTemplate = require '../tpl/button.html'
btnGroupTemplate = require '../tpl/buttonGroup.html'

class buttonViewModel extends BaseModel
  constructor: (params, componentInfo) ->
    super params
    @data = ko.dataFor componentInfo.element

    ieVersion = ko.utils.ieVersion ? 10
    @can_use_animate = ieVersion > 9 #判断是否支持animate
    @click = if params.click then params.click.bind(@data) else ->
    @active = ko.observable false
    @hover = ko.observable false

    @disable = ko.pureComputed =>
      ko.unwrap params.disable or false

    @loading = ko.pureComputed =>
      ko.unwrap params.loading or false

    @href = ko.pureComputed =>
      ko.unwrap params.href or 'javascript:;'

    @size = ko.pureComputed =>
      ko.unwrap params.size or null

    @type = ko.pureComputed ->
      ko.unwrap params.type or null

    @cls = ko.pureComputed =>
      cls = 'ko-button'
      if @type()?
        cls = "#{cls} ko-#{@type()}"

      if componentInfo.templateNodes.length is 0
        cls = "#{cls} ko-icon-only"

      if @active()
        cls = "#{cls} ko-active"

      if @hover()
        cls = "#{cls} ko-hover"

      shape = ko.unwrap params.shape or null
      if shape
        cls = "#{cls} ko-#{shape}"

      fluid = ko.unwrap params.fluid or null
      if fluid
        cls = "#{cls} ko-fluid"

      if @size()
        cls = "#{cls} ko-#{@size()}"

      if @disable() is on
        cls = "#{cls} ko-disable"

      cls

    @icon = ko.pureComputed =>
      ko.unwrap params.icon or null

    @disposes = @disposes.concat [@cls]

  mouseDown: ->
    @active on

  mouseUp: ->
    @active off

  mouseOver: ->
    @hover on

  mouseOut: ->
    @hover off
    
ko.components.register 'ko-button', {
  viewModel:
    createViewModel: (params, componentInfo) ->
      new buttonViewModel params, componentInfo
  template: btnTemplate
}

class buttonGroupViewModel
  constructor: (params, @componentInfo) ->
    @data = ko.dataFor @componentInfo.element

    @cls = ko.pureComputed ->
      cls = 'ko-button-group'
      shape = ko.unwrap params.shape or null
      if shape
        cls = "#{cls} ko-#{shape}"

      size = ko.unwrap params.size or null
      if size
        cls = "#{cls} ko-#{size}"

      vertical = ko.unwrap params.vertical or false
      if vertical
        cls = "#{cls} ko-vertical"

      cls

ko.components.register 'ko-button-group', {
  viewModel:
    createViewModel: (params, componentInfo) ->
      new buttonGroupViewModel params, componentInfo
  template: btnGroupTemplate
}