// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require switchery
//= require select2
//= require js/flot/jquery.flot.js
//= require js/flot/jquery.flot.pie.js
//= require js/flot/jquery.flot.orderBars.js
//= require js/flot/jquery.flot.time.min.js
//= require js/flot/date.js
//= require js/flot/jquery.flot.spline.js
//= require js/flot/jquery.flot.stack.js
//= require js/flot/curvedLines.js
//= require js/flot/jquery.flot.resize.js
//= require js/progressbar/bootstrap-progressbar.min.js
//= require js/icheck/icheck.min.js
//= require js/moment/moment.min.js
//= require js/datepicker/daterangepicker.js
//= require js/chartjs/chart.min.js
//= require js/pace/pace.min.js
//= require js/nprogress.js
//= require flash.js


$(document).ready(function() {

  $(".tags-multi-select").select2();
  $('.js-switch').on('change', function (event, state) {
    var self = this;
    // $(self).attr('disabled',true);

    var deviceId = $(this).data('device-slug');
    var triggeredState = state ? 'on' : 'off';

    var request = $.ajax({
      url: "devices/" + deviceId + "/toggle",
      type: "PUT",
      data: { state: triggeredState },
      dataType: "JSON"
    });

    request.success(function(data) {
      $(self).attr('disabled', false);
      if(!data.success) {
        $(self).bootstrapSwitch('state', !state, true);
        $('#flash-container').append('<div class="alert alert-dismissible alert-danger">' +
           '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
            data.message +
         '</div>');
      }
    });
  });
});




