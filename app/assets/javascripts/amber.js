var AMBER = AMBER || {};

AMBER.CONST = {
  lat: 4.944,
  lng: 114.928
}

AMBER.getForecast = function(lat, lng, success) {
  $.ajax({
    url: "/weather/forecast",
    method: "POST",
    data: {forecast: {lat: lat, lng: lng}},
    dataType: 'json',
    success: success
  });
}