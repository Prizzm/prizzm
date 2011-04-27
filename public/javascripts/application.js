$(document).ready(function(){

  /* Here, we initialize some of the Javascript plugins used for display, and
   * interactivity on the site
   */

  // Initialize best in place edit in place helper
  $(".best_in_place").best_in_place();

  // Initialize facebox model windows if they are used
  $('a[rel*=facebox]').facebox();




  /*  Here we configure the effects that occur when we click on the input box.
   *  The text_area expands in size, we add a class to it to highlight it, and we
   *  show three other objects that were previously hidden.  Finally, after we
   *  lose focus from the text_area, we remove the highlighting
   */

  $('#interaction-input').focus(function(){
    /*this.value = this.attr('data-text');    */
    $(this).addClass('input-active');
    $(this).height(80);
    $('#interaction_submit').show();
    $('.social img,input').show();
    $('#interaction_stars').show();
  });

  $('#interaction-input').blur(function(){
    $(this).removeClass('input-active');
  });




  /* This function is used to send the updated ratings to the Rails controller
   * via ajax.  As we do not need to read the response (we just assume it works,
   * we can use a simple AJAX Post.
   */
  update_rating = function(key, object, rating){
    $.post('/' + key + '/rate', {
      object_id: object,
      rating: rating
    });
  };









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



  // Used to hightlight tables when we hoover over them.  NEed to change to
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

  $('.interaction-content').hover(function(){
      $(this).addClass('hover');
    }, function(){
      $(this).removeClass('hover');
  });
});
