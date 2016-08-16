$(function(){

  $( "#sub-farm-tabs" ).tabs();
  
  $("[draggable='true']").on('dragend', function(){
    // alert('');
  });

  $(".farm-template").on('click', function(){
    $(this).siblings().removeClass('template-clicked');
    $(this).addClass('template-clicked');


    $('.draw-template').removeClass('template-circle');
    $('.draw-template').removeClass('template-square');
    $('.draw-template').addClass('template-' + $(this).data("template"));
  
    $('#sub_farm_x').val('30');
    $('#sub_farm_y').val('20');
    $('#sub_farm_width').val('300');
    $('#sub_farm_height').val('300');


  });

  $('.draw-template')
  .draggable({
    containment: "parent",
    stop: function(){
      // var offset = $(this).offset();

      var thisPos = $(this).position();
      var parentPos = $('.farm-layout').position();

      var x = thisPos.left;// - parentPos.left;
      var y = thisPos.top;// - parentPos.top;

      $("#sub_farm_x").val(x);
      $("#sub_farm_y").val(y);
      // console.log('x: ' + x);
      // console.log('y: ' + y);
    }
  })
  .resizable({
    stop: function(event, ui) {
      var width = ui.size.width;
      var height = ui.size.height;

      $("#sub_farm_width").val(width);
      $("#sub_farm_height").val(height);

      // console.log(width + ',' + height);
    }
  });
});