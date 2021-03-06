// Generated by CoffeeScript 1.10.0
(function() {
  var Wurker,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  Wurker = require('./wurker');

  module.exports = (function(superClass) {
    extend(_Class, superClass);

    _Class.context = 'window';

    function _Class(uri) {
      this.context = new window.Worker(uri);
      _Class.__super__.constructor.apply(this, arguments);
    }

    _Class.prototype.postMessage = function(message) {
      return this.context.postMessage(message);
    };

    _Class.prototype.addEventListener = function(event, handler) {
      return this.context.addEventListener(event, handler);
    };

    _Class.prototype.removeEventListener = function(event, handler) {
      return this.context.removeEventListener(event, handler);
    };

    return _Class;

  })(Wurker);

}).call(this);

//# sourceMappingURL=window.js.map
