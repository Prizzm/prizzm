$(document).ready(function(){
  /*  Logic to dynamically add and remove coomments from the page
   */

  // Handles slide expansion and focus for nested comments
  $('.reply-comment').live('click', function(e) {
    e.preventDefault();
    var container = $('#comment-' + $(this).attr('comment_id') + '-reply');
    if (container.is(":visible")) {
      container.slideUp();  
      $(this).html('reply');
    } else {
      container.slideDown();  
      container.find('textarea').focus();  
      $(this).html('cancel reply');
    }
  });


  $('#comment_comment').focus(function(){
    $(this).addClass('input-active');
    $('#comment_submit').show();
    $('#share-input .cancel').show();
    $('#new_comment_box .social').show();
    $('#comment_submit').show();
  });

  $('#share-input .cancel').click(clearComment);
  $('#item-comment-submit').click(clearComment);

  function clearComment(){
    $('#comment_comment').removeClass('input-active');
    $('#share-input .cancel').hide();
    $('#new_comment_box .social').hide();
    $('#comment_submit').hide();
    $('#comment_comment').val('');
  }


  /*  We will reuse the previous interaction logic here to handle the ajax
  *  comments
  */
  $('.new_comment')
    .live('ajax:success', function(event, data, status, xhr){
      // Add the newly created comment to the page, and alert the user.
      var new_comment = $("<ul class='comms'>"+ xhr.responseText+'</ul>');
      console.log(new_comment);
      var li_element = $(this).closest('li')
      li_element.append(new_comment);
      $(this).slideUp();
      li_element.find('.reply-comment').html('reply');
      li_element.find('ul:first-child').effect('highlight', {}, 2000);
  });


  /* Tis code is for deleting comments.  When our root comment collection
   * element detects an ajax:succcess event on a child 'a' element, it removes
   * the comment div from the page, where the comment div id is returned from
   * the controller
   */

  $('.comments_root').delegate('a.comment-delete-link', 'ajax:success', function(event, data, status, xhr){
    var commentid = data + '';
    $('#comment-' + commentid + '-content').find('.comment-body').replaceWith('<span class="comment-deleted">* Comment Deleted *</span>');
  });

});
