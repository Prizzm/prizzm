$(document).ready(function(){
  //Fading Links Using Jquery
  $.fn.dwFadingLinks = function(settings) {
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

  // Use fade link to nav header bar
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

  // For Facebook posting messages
  $('.shared_fb_checkbox').live('click', function() {
    if (($('#is_signed_in_fb').val() == 'false') && ($(this).attr('checked') == true)) {
      $('#processing_fb_id').val($(this).attr('id'));
      $(this).attr('checked', false);
      window.name = 'parent_of_facebook';
      window.open($('#omniauth_fb_login_path').val(), 'sign_in_facebook', 'height=600,width=800,scrollbars=yes');
    } 
  });

 
  // For Facebook posting messages
  $('.share_orphan').live('click', function() {
      window.name = 'parent_of_facebook';
      window.open($('#omniauth_fb_login_path').val(), 'sign_in_facebook', 'height=600,width=800,scrollbars=yes');
  });

  function checkWinFacebook() {
    if ((window.opener != null) && (window.opener.name == "parent_of_facebook")) {
      var opener = window.opener;
      var processing_fb_id = $(opener.document).find('#processing_fb_id');
      var fbCheckbox = $(opener.document).find('#' + $(processing_fb_id).val());
      var fbFlag = $(opener.document).find('#is_signed_in_fb');

      $(fbCheckbox).attr('checked', true);
      $(fbFlag).val(true);

      opener.focus();
      window.close();
    }
  }

  /*checkWinFacebook();*/

  // For Twitter posting message
  $('.shared_tt_checkbox').live('click', function() {
    if (($('#is_signed_in_tt').val() == 'false') && ($(this).attr('checked') == true)) {
      $('#processing_tt_id').val($(this).attr('id'));
      $(this).attr('checked', false);
      window.name = 'parent_of_twitter';
      window.open($('#omniauth_tt_login_path').val(), 'sign_in_twitter', 'height=600,width=800,scollbars=yes');
    }
  });

  function checkWinTwitter() {
    if ((window.opener != null) && (window.opener.name == "parent_of_twitter")) {
      var opener = window.opener;
      var processing_tt_id = $(opener.document).find('#processing_tt_id');
      var ttCheckbox = $(opener.document).find('#' + $(processing_tt_id).val());
      var ttFlag = $(opener.document).find('#is_signed_in_tt');

      $(ttCheckbox).attr('checked', true);
      $(ttFlag).val(true);

      opener.focus();
      window.close();
    }
  }

  /*checkWinTwitter();*/

  /* Now we need to configure the checkboxes to create an association between
   * the items, and the interaction that is being created.  First we will bind a
   * function to the click event, and if the box is then checked, we will add
   * the item id to the list of interaction items.  If it is unchecked, we will
   * remove the item from the list of interaction items.
   */
  /*$('#interaction_submit').click(function(){*/
  /*// First get a list of all the checked Items*/
  /*var checked_items = new Array();*/
  /*$('#items input[type="checkbox"]:checked').each(function(){*/
  /*checked_items.push(this.getAttribute('data-item-id'));*/
  /*});*/

  /*// Then add this list of items to the new_interaction form to be submitted*/
  /*$('#interaction_new_items').val(checked_items);*/
  /*});*/

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

  /* This is where we handle the deleted interactions */
  /* The code sets up an event handler on the #interactions_feed element, so if
   * any of its child interactions are deleted, it gets handled here.  This
   * helps us avoid having to set up n event handlers on the page, by just
   * setting one on the parent element
   */
  $('#interactions_feed').delegate('a', 'ajax:success', function(event, data, status, xhr){
    var interactionid = data + '';
    $('#interaction-' + interactionid + '-content').fadeOut();
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

  _.templateSettings = {
    interpolate: /\{\{(.+?)\}\}/g
  }
});

