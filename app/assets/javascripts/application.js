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
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-switch
//= require turbolinks
//= require_tree .

$(document).ready(function() {

  $('.bootstrap-switch').bootstrapSwitch({
    onColor: 'success',
    offColor: 'danger',
    size: 'small'
  });

  $('.device-state-handler').on('switchChange.bootstrapSwitch', function (event, state) {
    var self = this;
    $(self).bootstrapSwitch('disabled',true);

    var deviceId = $(this).parents('.panel-body').find('input:hidden')[0].value;
    var triggeredState = state ? 'on' : 'off'

    var request = $.ajax({
      url: "devices/" + deviceId + "/toggle",
      type: "PUT",
      data: { state: triggeredState },
      dataType: "JSON"
    });

    request.success(function(data) {
      $(self).bootstrapSwitch('disabled', false);
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
