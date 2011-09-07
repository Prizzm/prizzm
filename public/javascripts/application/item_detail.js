$(document).ready(function(){
  $('#opinion').bind('change', function() {
    $(this).closest('form').submit();
  });
});
