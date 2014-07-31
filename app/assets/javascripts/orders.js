jQuery(function($) {

  $(".add").click( function() {

    if(confirm("Точно добавить")) {
      $.ajax({
        url: '/orders/change_qty/'+$(current_item_tr).attr(),
        type: 'POST',
        data: { _method: 'PUTCH' },
        success: function() {

        }
      });
    }
  });

  $(".deleteAction").click( function() {
    var current_item_tr = $(this).parents('tr')[0];
    if(confirm("Точно удалить?")) {
      $.ajax({
        url: '/line_items/' + $(current_item_tr).attr('data-item_id'),
        type: 'POST',
        data: { _method: 'DELETE' },
        success: function() {
          $(current_item_tr).fadeOut(200);
        }
      });
    } 
  });

});