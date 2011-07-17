$(document).ready(function(){
  // Privacy ccontrols ffor items.  Control is a ajax link wich sends a put
  // request to toggle te privacy.  Tis script sets a return handler, to show
  // the updateed privacy mode, and toggle the css class.
  $('.privacy_control').live('ajax:success', function(event, data, status, xhr){
    $(this).html(data.item_privacy);
    $(this).removeClass(data.old_privacy).addClass(data.item_privacy);
  });
  
  /* Here, we initialize some of the Javascript plugins used for display, and
   * interactivity on the site
   */
  $(".autogrow").autoGrow();
  $(".facebox").facebox();
  clearInteraction();
   
  $('#interaction-input').focus(function(){
    $(this).addClass('input-active');
    $('#interaction_submit').show();
    $('#share-input .cancel').show();
    $('#new_interaction_box .social').show();
    $('#item-interaction-submit').show();
  });

  $('#share-input .cancel').click(clearInteraction);
  $('#item-interaction-submit').click(clearInteraction);

  function clearInteraction(){
    $('#interaction-input').removeClass('input-active');
    $('#share-input .cancel').hide();
    $('#new_interaction_box .social').hide();
    $('#item-interaction-submit').hide();
    $('#interaction-input').val('');
  }

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

  $('#interactions_feed').delegate('a', 'ajax:success', function(event, data, status, xhr){
    var interactionid = data + '';
    $('#interaction-' + interactionid + '-content').fadeOut();
  });

  $('.delete-item').delegate('a', 'ajax:success', function(event, data, status, xhr){
    var itemid = data + '';
    $('#item_'+itemid).fadeOut();
  });

  $('.interaction-content').live('mouseenter', function(){
    $(this).addClass('hover');
  });

  $('.interaction-content').live('mouseleave', function(){
    $(this).removeClass('hover');
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


  /* Privacy controls to adjust item privace
   */
  $('.privacy_control').live('ajax:success', function(event, data, status, xhr){
    $(this).html(data.item_privacy);
    $(this).removeClass(data.old_privacy).addClass(data.item_privacy);
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


  /* Customized jquery.ui.stars plugin 
   */
  $(".rateable-item").stars({
    callback: function(ui, type, value, event){
      var item = ui.element.data('itemid');
      update_rating('items', item, value);
    }
  });

  /*Code to delete items frrom the main page*/
  $('.delete-item').delegate('a', 'ajax:success', function(event, data, status, xhr){
    var itemid = data + '';
    $('#item_'+itemid).fadeOut();
  });

  _.templateSettings = {
    interpolate: /\{\{(.+?)\}\}/g
  }
});
