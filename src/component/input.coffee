BaseModel = require './base'
template = require '../tpl/input.html'

ko.bindingHandlers.koxUpdateInputMargin = {
  update: (element, valueAccessor, allBindings) ->
    margin = allBindings.get 'inputMargin'
    setTimeout ->
      margin "#{element.offsetWidth}px"
    , 5
}

class viewModel extends BaseModel
  constructor: (params, componentInfo) ->
    super params
    @data = ko.dataFor componentInfo.element
    ieVersion = ko.utils.ieVersion ? 10
    can_use_placeholder = ieVersion > 9 #判断是否支持placeholder

    @marginLeft = ko.observable '8px'
    @marginRight = ko.observable '8px'

    @focus = ko.observable ko.unwrap params.hasFocus or false
    if ko.isObservable params.hasFocus
      @disposes.push @focus.subscribe (v) ->
        params.hasFocus v

    @type = ko.observable ko.unwrap params.type or 'text'

    @placeholder = ko.computed ->
      ko.unwrap params.placeholder or null

    params.value = params.value ? ko.observable null
    @origin_type = @type() #记录初始类型
    @value = ko.computed {
      read: ->
        value = ko.unwrap params.value or null
        #placeholder兼容处理
        if not can_use_placeholder and not value and not @focus()
          if @type() is 'password'
            @type 'text'
          return @placeholder()
        if @type() isnt @origin_type
          @type @origin_type
        value
      write: (value) ->
        if ko.isObservable params.value
          params.value value
      owner: @
    }

    @visible = ko.pureComputed ->
      ko.unwrap params.visible or true

    icon = ko.utils.extend {
      left: null
      right: null
    }, params.icon
    @left_icon = ko.pureComputed ->
      ko.unwrap icon.left
    @right_icon = ko.pureComputed ->
      ko.unwrap icon.right

    label = ko.utils.extend {
      left: null
      right: null
    }, params.label
    @left_label = ko.pureComputed ->
      ko.unwrap label.left
    @right_label = ko.pureComputed ->
      ko.unwrap label.right

    labelClick = ko.utils.extend {
      left: null
      right: null
    }, params.labelClick
    @left_label_click = if labelClick.left then labelClick.left.bind(@data) else @labelClick
    @right_label_click = if labelClick.right then labelClick.right.bind(@data) else @labelClick

    @size = ko.pureComputed ->
      ko.unwrap params.size or null

    @disable = ko.pureComputed ->
      ko.unwrap params.disable or null

    @leftListener = ko.pureComputed =>
      @left_icon() or @left_label()

    @rightListener = ko.pureComputed =>
      @right_icon() or @right_label()

    @disposes = @disposes.concat [
      @value, @visible, @left_icon, @right_icon, @left_label, @right_label
      @size, @placeholder, @disable, @leftListener, @rightListener
    ]

  labelClick: ->
    @focus on

ko.components.register 'ko-input', {
  viewModel:
    createViewModel: (params, componentInfo) ->
      new viewModel params, componentInfo
  template: template
}