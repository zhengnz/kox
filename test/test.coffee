class viewModel
  constructor: ->
    @active = ko.observable off
    @data = ko.observable 'Hello World!'
    @size = ko.observable 8
    @gutter = ko.observable 16

    @input_value = ko.observable null

  test_click: ->
    alert @data()

  set_value: ->
    @input_value 'Hello World!'

ko.applyBindings new viewModel()