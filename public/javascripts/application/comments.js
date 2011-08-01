$(document).ready(function(){
  /*  Logic to dynamically add and remove coomments from the page
   */

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

  $('.comment-content').live('mouseenter', function(){
    $(this).addClass('hover');
  });

  $('.comment-content').live('mouseleave', function(){
    $(this).removeClass('hover');
  });


  /*  We will reuse the previous interaction logic here to handle the ajax
  *  comments
  */
  $('#new_comment')
    .live('ajax:success', function(event, data, status, xhr){
      // Add the newly created comment to the page, and alert the user.
      $('#comments_feed').prepend(xhr.responseText);
      $('#comments_feed .comment-content:first-child').effect('highlight', {}, 2000);

      //http://stackoverflow.com/questions/680241/blank-out-a-form-with-jquery
      $(':input','#new_comment')
      .not(':button, :submit, :reset, :hidden')
      .val('');

      $('#new_comment')[0].reset();
  });


  /* Tis code is for deleting comments.  When our root comment collection
   * element detects an ajax:succcess event on a child 'a' element, it removes
   * the comment div from the page, where the comment div id is returned from
   * the controller
   */

  $('#comments_feed').delegate('a', 'ajax:success', function(event, data, status, xhr){
    var commentid = data + '';
    $('#comment-' + commentid + '-content').fadeOut();
  });
});
