// Generated by CoffeeScript 1.12.1
(function() {
  var BaseModel, template, viewModel,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  BaseModel = require('./base');

  template = require('../tpl/icon.html');

  viewModel = (function(superClass) {
    extend(viewModel, superClass);

    function viewModel(params) {
      var config;
      viewModel.__super__.constructor.call(this, params);
      config = ko.utils.extend({
        search: '&#xe660;',
        toggle: '&#xe940;',
        'toggle-filled': '&#xe8c6;',
        locked: '&#xe81e;',
        unlocked: '&#xe949;'
      }, global.koxIconConfig || {});
      this.type = ko.pureComputed(function() {
        return config[ko.unwrap(params.type)];
      });
      this.cls = ko.pureComputed(function() {
        var cls, color, size;
        cls = 'iconfont ko-icon';
        size = ko.unwrap(params.size || null);
        if (size != null) {
          cls = cls + " ko-" + size;
        }
        color = ko.unwrap(params.color || null);
        if (color != null) {
          cls = cls + " ko-" + color;
        }
        return cls;
      });
      this.disposes = this.disposes.concat([this.type, this.cls]);
    }

    return viewModel;

  })(BaseModel);

  ko.components.register('ko-icon', {
    viewModel: {
      createViewModel: function(params, componentInfo) {
        return new viewModel(params);
      }
    },
    template: template
  });

}).call(this);

//# sourceMappingURL=icon.js.map
