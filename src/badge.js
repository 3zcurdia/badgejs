(function() {
  (function($) {
    $.badger = function(item, options) {
      var easyNumber, setBadges,
        _this = this;
      this.item = item;
      this.options = $.extend({
        remote_style: true
      }, options);
      easyNumber = function(num) {
        var fraction, x, _i, _len, _ref;
        fraction = num;
        _ref = ['', 'k', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y'];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          x = _ref[_i];
          if (fraction < 1000) {
            return "" + (parseInt(fraction)) + x;
          } else {
            fraction /= Math.pow(10, 3);
          }
        }
      };
      setBadges = function(languages) {
        var lang, languagesSorted, _i, _len, _results;
        if (typeof languages["Stars"] !== 'undefined') {
          _this.item.append("<span class='badge-stars' title='It has more than " + (easyNumber(languages["Stars"])) + " stars'></span>");
          delete languages.Stars;
        }
        languagesSorted = Object.keys(languages).sort(function(a, b) {
          return languages[b] - languages[a];
        });
        _results = [];
        for (_i = 0, _len = languagesSorted.length; _i < _len; _i++) {
          lang = languagesSorted[_i];
          _results.push(_this.item.append("<span class='badge-" + (lang.toLowerCase()) + "' title='It has more than " + (easyNumber(languages[lang])) + " lines of " + lang + " code'></span>"));
        }
        return _results;
      };
      $.get("https://greport.herokuapp.com/gh/" + this.options.username + "/languages/").done(function(data) {
        return setBadges(data);
      });
      return true;
    };
    $.fn.badger = function(options) {
      return $.badger($(this), options);
    };
  })(jQuery);

}).call(this);
