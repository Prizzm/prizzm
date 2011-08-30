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
});
