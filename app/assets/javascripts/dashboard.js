$(function() {
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