BaseModel = require './base'
template = require '../tpl/col.html'

class viewModel extends BaseModel
  constructor: (params, parent, componentInfo) ->
    super params
    @data = parent.$context

    @e = componentInfo.element.firstChild
    ko.utils.toggleDomNodeCssClass @e, "ko-col", true
    @pre = {}

    @col_class 'span', params.size
    @col_class 'pull', params.pull
    @col_class 'push', params.push
    @col_class 'offset', params.offset

    @col_class 'lg-span', params.lgSize
    @col_class 'lg-pull', params.lgPull
    @col_class 'lg-push', params.lgPush
    @col_class 'lg-offset', params.lgOffset

    @col_class 'md-span', params.mdSize
    @col_class 'md-pull', params.mdPull
    @col_class 'md-push', params.mdPush
    @col_class 'md-offset', params.mdOffset

    @col_class 'sm-span', params.smSize
    @col_class 'sm-pull', params.smPull
    @col_class 'sm-push', params.smPush
    @col_class 'sm-offset', params.smOffset

    @disposes.push ko.computed =>
      gutter = ko.unwrap parent.gutter or null
      if gutter?
        px = "#{Math.floor gutter / 2}px"
        @e.firstChild.style['margin-left'] = px
        @e.firstChild.style['margin-right'] = px
      else
        @e.firstChild.style['margin-left'] = 'auto'
        @e.firstChild.style['margin-right'] = 'auto'

    @visible = ko.pureComputed ->
      ko.unwrap params.visible ? true
    @disposes.push @visible

  col_class: (name, observable) ->
    @disposes.push ko.computed =>
      value = ko.unwrap observable ? null
      if @pre[name]?
        ko.utils.toggleDomNodeCssClass @e, "ko-#{name}-#{@pre[name]}", false
      if value?
        ko.utils.toggleDomNodeCssClass @e, "ko-#{name}-#{value}", true
      @pre[name] = value

ko.components.register 'ko-col', {
  viewModel:
    createViewModel: (params, componentInfo) ->
      parent = ko.dataFor componentInfo.element
      new viewModel params, parent, componentInfo
  template: template
}