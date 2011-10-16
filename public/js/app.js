(function (ctx) {
  var App = ctx.App = {};

  App.Geo = {
    init: geo_position_js.init,
    locate: function (success, fail) {
      if (!App.Geo.inProgress) {
        geo_position_js.getCurrentPosition(success, fail);
      }
    },
    inProgress: false,
    onSuccess: function (pos) {
      $('#manual_location').val(pos.coords.latitude + ',' + pos.coords.longitude);
    },
    onFailure: function (e) {
      alert('Error geolocating.');
    }
  };

  App.init = function () {
    if (geo_position_js.init()){
      $('#geolocate_link').click(function () {
        geo_position_js.getCurrentPosition(App.Geo.onSuccess, App.Geo.onFailure);
        return false;
      }).show();
    }
  };

}(this));
