$(function() {
  $('#timeline-container').highcharts({
    chart: {
        type: 'spline',
        animation: Highcharts.svg, // don't animate in old IE
        marginRight: 10,
        events: {
            load: function () {

                // set up the updating of the chart each second
                var series = this.series[0];
                setInterval(function () {
                    var x = (new Date()).getTime(), // current time
                        y = Math.random() * (35 - 20) + 20;
                    series.addPoint([x, y], true, true);
                }, 5000);
            }
        }
    },
    credits: {enabled: false},
    title: {
        text: 'Live random data'
    },
    xAxis: {
        type: 'datetime',
        tickPixelInterval: 150
    },
    yAxis: {
        title: {
            text: 'Value'
        },
        min: 0,
        max: 40,
        tickInterval: 5,
        plotLines: [{
            value: 0,
            width: 1,
            color: '#808080'
        }]
    },
    tooltip: {
        formatter: function () {
            return '<b>' + this.series.name + '</b><br/>' +
                Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
                Highcharts.numberFormat(this.y, 2);
        }
    },
    legend: {
        enabled: false
    },
    exporting: {
        enabled: false
    },
    series: [{
        name: 'Random data',
        data: (function () {
            // generate an array of random data
            var data = [],
                time = (new Date()).getTime(),
                i;

            for (i = -19; i <= 0; i += 1) {
                data.push({
                    x: time + i * 5000,
                    y: Math.random() * (35 - 20) + 20
                });
            }
            return data;
        }())
    }]
  });
  
  $(document).on('click', '#modal-submit', function() {
    $('#actionsModal form').submit().bind('ajax:complete', function() {
      $('#actionsModal').modal('hide').promise().done(function() {
        $('#actionsModal form').trigger("reset");
        $('#actionsModal .ajax-loader').hide();
        $('#actionsModal form').show();
      });
    });
    $('#actionsModal .ajax-loader').show();
    $('#actionsModal form').hide();
  });

  $('#actionsModal').on('show.bs.modal', function(event) {
    var button = $(event.relatedTarget);
    var action = button.data('action');

    $(this).find('.modal-header').removeClass("Water-Crops Fertilize-Farm ApplyChemicals").addClass(action.replace(/\s/g,"-")).find('.modal-title').text(action);
    $(this).find('.modal-body select#sub_farm_activity_activity_id option:contains('+action+')').prop('selected', true);

  });

  // $(document).on('submit', '#actionsModal form', function() {
  //   event.preventDefault();
  //   $.ajax({
  //     method: "POST",
  //     url: 'http://localhost:3000/sub_farm_activities',
  //     data: $('#actionsModal form').serialize(),
  //     success: function(data) {
  //       location.reload();
  //     }
  //   });
  // });
});