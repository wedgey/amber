$(function(){
  $("[draggable='true']").on('dragend', function(){
    // alert('');
  });

  $(".farm-template").on('click', function(){
    $(this).siblings().removeClass('template-clicked');
    $(this).addClass('template-clicked');


    $('.draw-template').removeClass('template-circle');
    $('.draw-template').removeClass('template-square');
    $('.draw-template').addClass('template-' + $(this).data("template"));
  });

  $('.draw-template')
  .draggable({
    stop: function(){
      // var offset = $(this).offset();

      var thisPos = $(this).position();
      var parentPos = $(this).parent().position();

      var x = thisPos.left - parentPos.left;
      var y = thisPos.top - parentPos.top;

      $("input[name='x']").val(x);
      $("input[name='y']").val(y);
      console.log('x: ' + x);
      console.log('y: ' + y);
    }
  })
  .resizable({
    stop: function(event, ui) {
      var width = ui.size.width;
      var height = ui.size.height;

      $("input[name='w']").val(width);
      $("input[name='h']").val(height);

      console.log(width + ',' + height);
    }
  });
});