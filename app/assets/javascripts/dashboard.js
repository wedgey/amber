AMBER.DASHBOARD = AMBER.DASHBOARD || {};

AMBER.DASHBOARD.init = function(timeLineEle, farmName, lastActivity, harvestTrackerEle, subFarm, potentialYield) {
  AMBER.getForecast(AMBER.CONST.lat, AMBER.CONST.lng, function(data) {
    AMBER.DASHBOARD.createTimeline(timeLineEle, farmName, lastActivity, data.forecast);
    AMBER.DASHBOARD.createNotifications(data);
  });
  AMBER.DASHBOARD.createHarvestTracker(harvestTrackerEle, subFarm, potentialYield);
}

AMBER.DASHBOARD.createTimeline = function(ele, farmName, lastActivity, weatherData) {
  var generateColor = function(arr) {
    var stops = [];
    var colorLegend = ['#a1a1a1', '#69d2e7', '#fa6900', '#000000'];
    if (arr.length == 1) {
      stops.push([0, colorLegend[arr[0]]]);
    } else {
      arr.forEach(function(ele, idx) {
        arr2 = [(Number(idx)/(arr.length-1)), colorLegend[ele]];
        stops.push(arr2);
      });
    }
    return {
      linearGradient: {x1: 0, y1: 0, x2: 0, y2: 1},
      stops: stops
    }
  }

  var generatePlotBands = function() {
    var lastActivities = JSON.parse(lastActivity);
    var offsets = [0, 432000000, 864000000, 1210000000];
    var result = [];
    for (var key in lastActivities) {
      var date = key.split("-");
      result.push({
        color: generateColor(lastActivities[key]),
        from: Date.UTC(date[0],date[1] - 1,date[2]) - 43200000,
        to: Date.UTC(date[0],date[1] - 1,date[2]) + 43200000
      });
    }
    return result;
  }

  console.log('createTimeline');
  var date = weatherData.simpleforecast.forecastday[0].date;
  ele.highcharts({
    chart: {
      spacingTop: 50
    },
    credits: {enabled: false},
    title: {
      text: ""
    },
    xAxis: {
      plotBands: generatePlotBands(),
          tickInterval: 24 * 3600 * 1000, // one day
          type: 'datetime',
          min: Date.UTC(date.year, date.month-1, date.day) - 43200000,
          max: Date.UTC(date.year, date.month-1, date.day+9) + 43200000
        },
        series: [{
          name: "Date",
          data: (function() {
            var data = [];
            weatherData.simpleforecast.forecastday.forEach(function(weather) {
              data.push({
                y: (Number(weather.high.celsius) + Number(weather.low.celsius)) / 2,
                marker: { symbol: "url(" + weather.icon_url + ")" }
              });
            });
            return data;
          }()),
          pointStart: Date.UTC(date.year,date.month-1,date.day),
          pointInterval: 24 * 3600 * 1000
        }]
      });
}

AMBER.DASHBOARD.createHarvestTracker = function(ele, subFarm, potentialYield) {
  function calculateDaysDiff() {
    var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
    var firstDate = new Date(subFarm.harvest_date);
    var secondDate = new Date();

    var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(oneDay)));
    return diffDays;
  }

  ele.highcharts({
    chart: {
      type: 'solidgauge',
      marginTop: 15,
      marginBottom: 15
    },
    title: {
      text: 'Subfarm ' + subFarm.id,
      useHTML: true,
      margin: 10,
      verticalAlign: "top",
      style: {
        "fontSize": "12px"
      }
    },
    subtitle: {
      useHTML: true,
      text: 'Forecasted Yield: <strong>' + potentialYield + '</strong> kg/ha',
      verticalAlign: "bottom",
      style: {
        "fontSize": "12px"
      }
    },
    credits: {
      enabled: false
    },
    pane: {
      startAngle: 0,
      endAngle: 360,
      background: [{
        outerRadius: '100%',
        innerRadius: '60%',
        backgroundColor: 'rgba(105, 210, 231, 0.35)',
        borderWidth: 0
      }]
    },
    tooltip: {
      enabled: false
    },
    yAxis: {
      min: 0,
      max: 100,
      lineWidth: 0,
      tickPositions: []
    },
    plotOptions: {
      solidgauge: {
        borderWidth: '30px',
        dataLabels: {
          y: 5,
          borderWidth: 0,
          useHTML: true
        },
        linecap: 'square',
        stickTracking: true
      }
    },
    series: [{
      name: 'Harvest',
      borderColor: '#fa6900',
      data: [{
        color: '#fa6900',
        radius: '80%',
        innerRadius: '80%',
        y: (100 - calculateDaysDiff())
      }],
      dataLabels: {
        formatter: function() {
          return '<div style="text-align:center; margin-top:-30px; margin-left:-2px;"><span style="font-size: 20px">' + (100 - this.y) + '</span><br>days</div>'
        }
        // format: '<div style="text-align:center; margin-top:-30px; margin-left:-2px;"><span style="font-size: 20px">' + (100 - this.y) + '</span><br>days</div>'
      }
    }]
  });
}

AMBER.DASHBOARD.createNotifications = function(datavalue) {
  var HIGH_PRECIP_THRESHOLD = 1
  var HIGH_WIND_THRESHOLD = 1
  var FORECAST_DAYS = 3

  function createDateString(forecast_date){

    return  ' on ' + 
    forecast_date.monthname_short 
    + " " + 
    forecast_date.day;
  }

  function constructRainCell(precip){
    if (precip > HIGH_PRECIP_THRESHOLD){
      var rain_warn = "Warning"
      
      return $('<td></td>').text(rain_warn).addClass('warning');
    } else {
      return $('<td></td>');
    }
  }

  function constructWindCell(wind_val){
    if (wind_val > HIGH_PRECIP_THRESHOLD){
      var wind_warn = "Warning";
      return $('<td></td>').text(wind_warn).addClass('warning');
    } else {
      return $('<td></td>');
    }
  }

  console.log('get_crop_weather_forecast');
  forecast_array = datavalue.forecast.simpleforecast.forecastday;
  for (var i=0; i < FORECAST_DAYS ; i++) {
    var max_temp = (forecast_array[i].high.celsius);
    var low_temp = (forecast_array[i].low.celsius);
    var average_temp = ((parseInt(max_temp) + parseInt(low_temp)) / 2.0);
    var wind_val = (forecast_array[i].avewind.kph);

    var date_string = createDateString(forecast_array[i].date);

    var precip = (forecast_array[i].qpf_allday.mm);

    var date_value = 
    forecast_array[i].date.monthname_short 
    + " " + 
    forecast_array[i].date.day;

    var date_cell = $('<td></td>').text(date_value);
    $('#alert-date').append(date_cell);

    var rain_cell = constructRainCell(precip);
    $('#alert-rain').append(rain_cell);

    var wind_cell = constructWindCell(wind_val);
    $('#alert-wind').append(wind_cell);

  }
}

$(function() {
  $(document).on('click', '#modal-submit', function() {
    event.preventDefault();
    $('#actionsModal form').submit().bind('ajax:complete', function() {
      $('#actionsModal').modal('hide').promise().done(function() {
        // $('#actionsModal form').trigger("reset");
        // $('#actionsModal .ajax-loader').hide();
        // $('#actionsModal form').show();
        location.reload();
      });
    });
    $('#actionsModal .ajax-loader').show();
    $('#actionsModal form').hide();
  });

  $('#actionsModal').on('show.bs.modal', function(event) {
    var button = $(event.relatedTarget);
    var action = button.data('action');

    $(this).find('.modal-header').removeClass("Water-Crops Fertilize-Farm Apply-Chemicals Miscellaneous").addClass(action.replace(/\s/g,"-")).find('.modal-title').text(action);
    $(this).find('.modal-body select#sub_farm_activity_activity_id option:contains('+action+')').prop('selected', true);

  });
});