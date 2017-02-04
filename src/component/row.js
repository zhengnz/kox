// Generated by CoffeeScript 1.12.1
(function() {
  var BaseModel, template, viewModel,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  BaseModel = require('./base');

  template = require('../tpl/row.html');

  viewModel = (function(superClass) {
    extend(viewModel, superClass);

    function viewModel(params, componentInfo) {
      var e;
      viewModel.__super__.constructor.call(this, params);
      this.data = {
        $context: params.data,
        gutter: params.gutter || null
      };
      e = componentInfo.element.firstChild;
      this.disposes.push(ko.computed((function(_this) {
        return function() {
          var gutter, px;
          gutter = ko.unwrap(_this.data.gutter);
          if (gutter != null) {
            px = "-" + (Math.floor(gutter / 2)) + "px";
            e.style['margin-left'] = px;
            return e.style['margin-right'] = px;
          } else {
            e.style['margin-left'] = 'auto';
            return e.style['margin-right'] = 'auto';
          }
        };
      })(this)));
      this.visible = ko.pureComputed((function(_this) {
        return function() {
          var ref;
          return ko.unwrap((ref = params.visible) != null ? ref : true);
        };
      })(this));
      this.disposes.push(this.visible);
    }

    return viewModel;

  })(BaseModel);

  ko.components.register('ko-row', {
    viewModel: {
      createViewModel: function(params, componentInfo) {
        params.data = ko.dataFor(componentInfo.element);
        return new viewModel(params, componentInfo);
      }
    },
    template: template
  });

}).call(this);

//# sourceMappingURL=row.js.map
