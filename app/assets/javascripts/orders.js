jQuery(function($) {

  $(".add-quantity").click( function() {
    var current_item_tr = $(this).parents('tr')[0];
    $.ajax({
      url: '/change_add?id='+$(current_item_tr).attr('data-item_id'),
      type: 'POST',
      data: { _method: 'get' },
      success: function() {
        //  increment quantity 
        var quantity = parseInt(document.getElementById('quantity-'+$(current_item_tr).attr('data-item_id')).innerText, 10);
        quantity += 1;
        $('#quantity-'+$(current_item_tr).attr('data-item_id')).html(quantity);
        //  increment total quantity
        var total_line_items = parseInt(document.getElementById('total-line-items').innerText, 10);
        total_line_items += 1;
        $('#total-line-items').html(total_line_items)
        //  increment item price
        var item_price = parseInt(document.getElementById('item-price-'+$(current_item_tr).attr('data-item_id')).innerText, 10);
        var delta_price = item_price/(quantity-1);
        item_price += delta_price;
        $('#item-price-'+$(current_item_tr).attr('data-item_id')).html(item_price);
        //  increment total price
        var total_price = parseInt(document.getElementById('total-price').innerText, 10);
        total_price += delta_price;
        $('#total-price').html(total_price);
      }
    });

  });

  $(".delete-quantity").click( function() {
    var current_item_tr = $(this).parents('tr')[0];
    $.ajax({
      url: '/change_decrement?id='+$(current_item_tr).attr('data-item_id'),
      type: 'POST',
      data: { _method: 'get' },
      success: function() {
        var quantity = parseInt(document.getElementById('quantity-'+$(current_item_tr).attr('data-item_id')).innerText, 10);
        quantity -= 1;
        if(quantity > 0){
          //  decrement quantity
          $('#quantity-'+$(current_item_tr).attr('data-item_id')).html(quantity)
          //  decrement total quantity
          var total_line_items = parseInt(document.getElementById('total-line-items').innerText, 10);
          total_line_items -= 1;
          $('#total-line-items').html(total_line_items)
          //  decrement item price
          var item_price = parseInt(document.getElementById('item-price-'+$(current_item_tr).attr('data-item_id')).innerText, 10);
          var delta_price = item_price/(quantity+1);
          item_price -= delta_price;
          $('#item-price-'+$(current_item_tr).attr('data-item_id')).html(item_price);
          //  decrement total price
          var total_price = parseInt(document.getElementById('total-price').innerText, 10);
          total_price -= delta_price;
          $('#total-price').html(total_price);
        }
      }
    });

  });

  $(".deleteAction").click( function() {
    var current_item_tr = $(this).parents('tr')[0];
    if(confirm("Точно удалить?")) {
      $.ajax({
        url: '/line_items/' + $(current_item_tr).attr('data-item_id'),
        type: 'POST',
        data: { _method: 'DELETE' },
        success: function(result) {
          //  delete tr
          $(current_item_tr).fadeOut(200);
          //  change total quantity
          var quantity = parseInt(document.getElementById('quantity-'+$(current_item_tr).attr('data-item_id')).innerText, 10);
          var total_line_items = parseInt(document.getElementById('total-line-items').innerText, 10);
          total_line_items -= quantity;
          $('#total-line-items').html(total_line_items);
          //  change total price
          var total_price = parseInt(document.getElementById('total-price').innerText, 10);
          var item_price = parseInt(document.getElementById('item-price-'+$(current_item_tr).attr('data-item_id')).innerText, 10);
          total_price -= item_price;
          $('#total-price').html(total_price);

          console.log(result);
        }
      });
    } 
  });

});