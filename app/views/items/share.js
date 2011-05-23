<%- if @shared_fb -%>
  $($('.shared_fb_checkbox')[0]).attr('disabled', true);  
<%- end -%>

<%- if @shared_tt -%>
  $($('.shared_tt_checkbox')[0]).attr('disabled', true);  
<%- end -%>
