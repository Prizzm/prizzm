$(document).ready(function(){
  // Privacy ccontrols ffor items.  Control is a ajax link wich sends a put
  // request to toggle te privacy.  Tis script sets a return handler, to show
  // the updateed privacy mode, and toggle the css class.
  $('.privacy_control').live('ajax:success', function(event, data, status, xhr){
    $(this).html(data.item_privacy);
    $(this).removeClass(data.old_privacy).addClass(data.item_privacy);
  });
  
  // jax control for following links
  // Unfortunately has a strong binding to follow_controller json reesponse as
  // well as code in linkhelper.rb and routinghlper.rb
  $('.follow_control').live('ajax:success', function(event, data, status, xhr){
    $(this).replaceWith(data.link);
  });

  // Sames as above for follow and privacy links
  $('.block_control').live('ajax:success', function(event, data, status, xhr){
    $(this).replaceWith(data.link);
  });

  /* Here, we initialize some of the Javascript plugins used for display, and
   * interactivity on the site
   */

   $('a').click(function(){
	  if(this.hash != null){
		   window.linkHash = this.hash;
	  }
   });
   
    $('#product-search-submit-button').click(function() {
	  window.itemNamePrefil = $('#product-search-input').val();
	});
   
   $(".shared_checkbox").prop("checked", true);
  
  $("ul.social .cancel").click(function(){
	  $("#comment_shared_tt").prop("checked", false);
	  $("li.button.twitter").hide();
  });
  
  $(".facebox").facebox();
   
  $('.delete-item').delegate('a', 'ajax:success', function(event, data, status, xhr){
    console.log(data);
    var itemid = data + '';
    $('li#item_'+itemid).fadeOut();
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

  $(document).click(function(){
    if($('#main-dropdown').hasClass('show')) {
        $("#main-dropdown").toggleClass('hide show');
    }
  });
  
  $("#main-dropdown").click(function(){
    event.stopPropagation();
  });

  window.googleWebSearch = function(options){
    
    var config = {
      type		: 'web',
      append		: false,
      perPage		: 3,			// A maximum of 8 is allowed by Google
      page		: 0				// The start page
    }
    
    function googleSearch(settings){
  
      // If no parameters are supplied to the function,
      // it takes its defaults from the config object above:
      
      settings = $.extend({},config,settings);
      settings.term = settings.term;
      
      // URL of Google's AJAX search API
      var apiURL = 'http://ajax.googleapis.com/ajax/services/search/'+settings.type+'?v=1.0&callback=?';
      var resultsDiv = options.resultsDiv;
      
      resultsDiv.html("Searching Web");
      
      $.getJSON(apiURL,{q:settings.term,rsz:settings.perPage,start:settings.page*settings.perPage},function(r){
        
        var results = r.responseData.results;
        
        //alert(JSON.stringify(results));

        resultsDiv.html("");
        
        if ( resultsDiv.parent().hasClass('hide') ){
          resultsDiv.parent().toggleClass('show hide');
        }

        if (results.length){
          for (var i=0, len = results.length; i < len ; i++){
            var r = results[i];
            
            /*
             * 
             * {"GsearchResultClass":"GwebSearch",
             * "unescapedUrl":"http://www.facebook.com/",
             * "url":"http://www.facebook.com/",
             * "visibleUrl":"www.facebook.com",
             * "cacheUrl":"http://www.google.com/search?q=cache:QmfEpZb9ltYJ:www.facebook.com",
             * "title":"Welcome to <b>Facebook</b> - Log In, Sign Up or Learn More","titleNoFormatting":"Welcome to Facebook - Log In, Sign Up or Learn More",
             * "content":"<b>Facebook</b> is a social utility that connects people with friends and others who   <b>...</b> People use <b>Facebook</b> to keep up with friends, upload an unlimited number of   <b>...</b>"}
             * */

            var new_item = $("<li><a href='"+ r.unescapedUrl +"'>" + r.visibleUrl + "</a></li>");
            
            var new_item = $("<li>" + 
                             "<a class='result_item' href='"+ r.unescapedUrl +"'>" +
                             "<span class='r_title'>"+ r.titleNoFormatting +"</span><br />" +
                             "<span class='r_desc'>"+ r.content +"</span><br />" +
                             "<span class='r_vurl'>"+r.unescapedUrl+"</span>" +
                             "</a>" +
                             "</li>");
            
            new_item.children(".result_item").click(function(){
              var url = $(this).attr("href");
              $("#main-dropdown").toggleClass('hide show');
              $('#facebox input#item_url').val(url);
              //$("#status").val(url);
              //last_selected_url = url;
              $('#facebox input#item_url').change();
              return false;
            });
            new_item.appendTo(dropdown);
          }
        }

      });
    }
    
    config.term = options.q;
    googleSearch();
  };



});
