$(document).ready(function(){

  //http://devblog.foliotek.com/2009/07/23/make-table-rows-sortable-using-jquery-ui-sortable/
  var fixHelper = function(e, ui) {
    ui.children().each(function() {
      $(this).width($(this).width());
    });
    return ui;
  };

  var getStartOrder = function(event, ui){
    this.old_table_order = $(this).sortable('toArray').toString();
    this.old_table_order = $(this).sortable('toArray');
  };

  var saveOrder = function(event,ui){
    var new_table_order = $(this).sortable('toArray');
    var user_id = $('table.interactions').attr('data-user');
    $.post('/items/sort', {
      new_item_order: new_table_order, 
      old_item_order: this.old_table_order, 
      user_id: user_id
    }) //post order to rails
    $(this).find('.item_info').removeClass('hover');
  };

  $('tbody').sortable({
    helper: fixHelper,
    start: getStartOrder, 
    update: saveOrder
  }).disableSelection();

  //initialize facebox model windows
  $('a[rel*=facebox]').facebox();

  // Initialize best in place edit in place helper
  $(".best_in_place").best_in_place();

  // Used to hightlight tables when we hoover overe them.  NEed to change to
  // prevent duplicate effect on drop
  $('table.items tbody tr').hover(function(){
      $(this).find('.item_info').addClass('hover');
      var interactions_table = '#' + this.id + '_interactions';
      $('table.hidden').hide(); //hide all interactions that are currently visible
      $(interactions_table).show(); //show the interaction that we are interested in
    }, function(){
      var interactions_table = '#' + this.id + '_interactions';
      $(this).find('.item_info').removeClass('hover');
  });

  // Update item ratings via ajax
  update_item_rating = function(item, rating){
    $.post('/items/rate', {
      item_id: item,
      rating: rating
    }) //post order to rails
  };
});
