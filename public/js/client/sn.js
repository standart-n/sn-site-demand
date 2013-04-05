// Generated by CoffeeScript 1.5.0

$(function() {
  var methods;
  methods = {
    init: function(options) {
      var def, _this;
      if (options == null) {
        options = {};
      }
      def = {
        content: {},
        geo: {
          lat: '',
          lon: '',
          city: '',
          region: '',
          country: ''
        },
        result: {
          key: ''
        }
      };
      $.extend(true, def, options);
      $(this).data('sn', def);
      _this = $(this);
      $(this).snDemand('geoIp');
      $('#demand-name').live('keyup', function() {
        return _this.snDemand('checkName', $(this).val());
      });
      $('#demand-phone').live('keyup', function() {
        return _this.snDemand('checkPhone', $(this).val());
      });
      $('#push-demand').live('click', function() {
        $('#wall-demand').show().css({
          width: $(document).width(),
          height: $(document).height()
        });
        return $('#modal-demand').show();
      });
      $('.modal-header a.close').live('click', function() {
        $('#wall-demand').hide();
        return $('#modal-demand').hide();
      });
      $('#modal-close').live('click', function() {
        $('#wall-demand').hide();
        return $('#modal-demand').hide();
      });
      return $('#modal-send').live('click', function() {
        if ($(this).snDemand('check')) {
          $('.demand-success p').show();
          $('.demand-error p').hide();
          $('#modal-send').hide();
          return _this.snDemand('send');
        } else {
          $('.demand-success p').hide();
          return $('.demand-error p').show();
        }
      });
    },
    send: function() {
      var sn;
      sn = $(this).data('sn');
      $(this).snDemand('addToBase');
      return $(this).snDemand('addToGit');
    },
    geoIp: function() {
      var sn, _this;
      _this = $(this);
      sn = $(this).data('sn');
      return $.ajax({
        url: 'http://j.maxmind.com/app/geoip.js',
        dataType: 'script',
        timeout: 5000,
        success: function() {
          sn.geo = {
            lat: geoip_latitude(),
            lon: geoip_longitude(),
            city: geoip_city(),
            region: geoip_region(),
            country: geoip_country_name()
          };
          return _this.data('sn', sn);
        }
      });
    },
    addToBase: function() {
      var sn;
      sn = $(this).data('sn');
      return $.ajax({
        url: 'http://www.standart-n.ru/external/ajax_claim.php',
        type: 'GET',
        data: {
          act: 'add',
          name: $('#demand-name').val(),
          tel: $('#demand-phone').val(),
          email: $('#demand-email').val(),
          comment: $('#demand-comment').val(),
          skype: '',
          icq: '',
          site: '',
          lat: sn.geo.lat,
          lon: sn.geo.lon,
          city: sn.geo.city,
          region: sn.geo.region,
          country: sn.geo.country
        },
        dataType: 'text',
        timeout: 5000
      });
    },
    addToGit: function() {
      var message, sn;
      sn = $(this).data('sn');
      message = '' + $('#demand-name').val() + ' ' + $('#demand-phone').val() + ' ' + $('#demand-email').val() + ' ' + sn.geo.city + ' ' + $('#demand-comment').val() + ' ';
      return $.ajax({
        url: 'http://git.st-n.ru/',
        type: 'GET',
        data: {
          action: 'addClaim',
          msg: message
        },
        dataType: 'text',
        timeout: 1000,
        success: function(s) {
          return alert(s);
        }
      });
    },
    check: function() {
      return $(this).snDemand('checkName', $('#demand-name').val()) && $(this).snDemand('checkPhone', $('#demand-phone').val());
    },
    checkName: function(val) {
      var flag;
      if (val == null) {
        val = '';
      }
      flag = $(this).snDemand('flagName', val);
      if (flag) {
        $('#validate-name .validate-true').show();
        $('#validate-name .validate-false').hide();
      } else {
        $('#validate-name .validate-true').hide();
        $('#validate-name .validate-false').show();
      }
      return flag;
    },
    checkPhone: function(val) {
      var flag;
      if (val == null) {
        val = '';
      }
      flag = $(this).snDemand('flagPhone', val);
      if (flag) {
        $('#validate-phone .validate-true').show();
        $('#validate-phone .validate-false').hide();
      } else {
        $('#validate-phone .validate-true').hide();
        $('#validate-phone .validate-false').show();
      }
      return flag;
    },
    flagName: function(name) {
      var flag;
      if (name == null) {
        name = '';
      }
      flag = true;
      if (name === "" || name === "+7") {
        flag = false;
      }
      if (name.length < 2 || name.length > 30) {
        flag = false;
      }
      if (!/[^a-z0-9\.\,\"\?\!\;\:\#\$\%\&\(\)\*\+\-\/\<\>\=\@\[\]\\\^\_\{\}\|\~]+/i.test(name)) {
        flag = false;
      }
      return flag;
    },
    flagPhone: function(phone) {
      var flag;
      if (phone == null) {
        phone = '';
      }
      flag = true;
      if (phone === "" || phone === "+7") {
        flag = false;
      }
      if (phone.length < 5 || phone.length > 30) {
        flag = false;
      }
      if (!/\+?\d{1,3}(?:\s*\(\d+\)\s*)?(?:(?:\-\d{1,3})+\d|[\d\-]{4,}|(?:\s\d{1,3})+\d)/i.test(phone)) {
        flag = false;
      }
      return flag;
    }
  };
  return $.fn.snDemand = function(sn) {
    if (sn == null) {
      sn = {};
    }
    if (methods[sn]) {
      return methods[sn].apply(this, Array.prototype.slice.call(arguments, 1));
    } else {
      if (typeof sn === 'object' || !sn) {
        return methods.init.apply(this, arguments);
      } else {
        return $.error('Метод ' + sn + ' не существует');
      }
    }
  };
});
