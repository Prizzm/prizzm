$(document).ready(function(){

  jQuery.fn.dwFadingLinks = function(settings) {
	settings = jQuery.extend({
		color: '#ff8c00',
		duration: 500
	}, settings);
	return this.each(function() {
		var original = $(this).css('color');
		$(this).mouseover(function() { $(this).animate({ color: settings.color },settings.duration); });
		$(this).mouseout(function() { $(this).animate({ color: original },settings.duration); });
	});
};

 $('li a').dwFadingLinks({
				color: '#4789B4',
				duration: 600
			});

  
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



  /* Now we need to configure the checkboxes to create an association between
   * the items, and the interaction that is being created.  First we will bind a
   * function to the click event, and if the box is then checked, we will add
   * the item id to the list of interaction items.  If it is unchecked, we will
   * remove the item from the list of interaction items.
   */
  $('#interaction_submit').click(function(){
      // First get a list of all the checked Items
      var checked_items = new Array();
      $('#items input[type="checkbox"]:checked').each(function(){
        checked_items.push(this.getAttribute('data-item-id'));
      });

      // Then add this list of items to the new_interaction form to be submitted
      $('#interaction_new_items').val(checked_items);
  });



  /* This prepends the new interaction to our list of interactions, so that it
   * shows up at the top on our page, without us having to refresh the page
   * manually.
   * Once the new interaction is added to the page, we'd like to signal the user
   * so that it grabs their attention.
  */
  $('#new_interaction')
    .live('ajax:success', function(event, data, status, xhr){
      // Add the newly created interaction to the page, and alert the user.
      $('#interactions_feed').prepend(xhr.responseText);
      $('#interactions_feed .interaction-content:first-child').effect('highlight', {}, 2000)

      //http://stackoverflow.com/questions/680241/blank-out-a-form-with-jquery
      $(':input','#new_interaction')
        .not(':button, :submit, :reset, :hidden')
        .val('')
        .removeAttr('checked')
        .removeAttr('selected');

      $('#new_interaction')[0].reset();
    });



  /* This  creates the blue highlight effect as we mouseover the interactions
   * list, by adding the 'hover' class to the div on mouseover, and removing
   * it as the mouse moves away
   */

  $('.interaction-content').live('mouseenter', function(){
      $(this).addClass('hover');
  });
  $('.interaction-content').live('mouseleave', function(){
      $(this).removeClass('hover');
  });







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



});



