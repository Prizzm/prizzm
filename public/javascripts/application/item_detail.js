$(document).ready(function(){
  $('#opinion').bind('change', function() {
    $(this).closest('form').submit();
    $(this).next().show();
  });

  $('form').has('#opinion').bind('ajax:success', function() {
    $('form .loading').hide();
  });
});
