/* Prizzm : Application */

var Prizzm = {
  
  /* Initialize */
  init : function () {
    Prizzm.wizards.init();
  },
  
  /* Helpers */
  
  at : function (path) {
    return window.location.pathname == path;
  },
  
  exists : function (selector) {
    return $(selector).size() > 0;
  },
  
  param : function (matcher) {
    return window.location.search == matcher;
  },
  
  /* Wizards */
  
  wizards : {
    
    init : function () {
      
      if( Prizzm.exists("#main .action-menu") && Prizzm.param("?welcome") )
        this.welcome(0);
        
    },
    
    welcome : function (startAt) {
      
      // Helpers
      var concat = function () {
        var html = $('<div class="step">');
        $.each(arguments, function (index, value) {
          html.append(value);
        });
        return html;
      }
      
      var close = function (message) {
        return $('<a href="javascript:void(0)" class="manual-close">').text(message)
          .click(function () { $('#ui-tooltip-welcome-steps').triggerHandler('close') });
      }
      
      var go = function (event, message) {
        return $('<a href="javascript:void(0)" class="' + event + '">').text(message)
          .click(function () { $('#ui-tooltip-welcome-steps').triggerHandler(event); });
      }
      
      var next = function (message) { return go('next', message) };
      var prev = function (message) { return go('prev', message) };
      
      // Steps
      new Prizzm.wizards.Stepper( 
        "welcome-steps", startAt || 0, [
        
          // Step 1
          { 
            target: $('#prizzmbar'),
            content: concat(
              "<h1>Hi There!</h1>",
              "<p>Looks like you're new here, that's great!</p>",
              "<p>If you'd like, I can help you get familiarized with <mark>Prizzm..</mark></p>",
              "<p>What do ya say?</p>",
              close('No thanks..'),
              next('Lets go!')
            )
          },
        
          // Step 2
          {
            target: $('#main .action-menu'),
            my : 'top left',
            at : 'bottom left',
            content : concat(
              "<p><mark>Prizzm</mark> is a new way for you to interact with the products you buy &amp; the companies who make them!</p>",
              "<p>We give you three simple ways to get what's on your mind, out into the world!</p>",
              "<p>Share things you already <mark>have</mark>, things you <mark>want</mark>, &amp; the issues (<mark>cases</mark>) you have with them.</p>",
              next("Great, what's next?")
            )
          },
          
          // Step 3
          {
            content : concat(
              "<p>Let's start by getting to know you a little better!</p>",
              "<p>What's your <mark>first &amp; last name?</mark></p>",
              next("Right!")
            ),
            
            at : 'bottom center',
            my : 'top center',
            
            before : function (api, current, setup) {
              $.get('/accounts/edit', 
                { back : window.location.href }, 
                function (data) { 
                  $(document).bind('afterReveal.facebox', function() {
                    $(this).unbind('afterReveal.facebox');
                  
                    $("#user_first_name").focus();
                    current.target = $("#user_last_name");

                    setup.call();
                  });
                
                  $.facebox(data);
                }); 
            }
          },
          
          // Step 4
          {
            at : 'bottom center',
            my : 'top center',
            content : concat(
              "<p>So, what do we need your <mark>phone number</mark> for?</p>",
              "<p><mark>Prizzm</mark> just happens to have some really cool calling features built right in!</p>",
              "<p>Let's say you're having trouble with your cell service &amp; you need to contact customer service..</p>",
              "<p><mark>Prizzm</mark> will dail the best number for you, connect you &amp; record the call to ensure you're treated fairly!</p>",
              next("Sweet! What's next?")
            ),
            before : function (api, current, setup) {
              current.target =  $('#user_phone_number');
              setup.call();
            }
          },
          
          // Step 5
          {
            at : 'bottom center',
            my : 'top center',
            content : concat(
              "<p>Next, <mark>select a photo to upload</mark> of yourself if you'd like!</p>",
              "<p>This will make it easier for your friends to recognize you.</p>",
              next("Alright!")
            ),
            before : function (api, current, setup) {
              current.target = $('#user_photo');
              setup.call();
            }
          },
          
          // Step 6
          {
            content : concat(
              "<p>You're just about there!</p>",
              "<p>Go ahead &amp; <mark>enter your password</mark>, so we know it's you!</p>",
              next("And then..")
            ),
            before : function (api, current, setup) {
             current.target = $('#user_current_password');
             setup.call();
            }
          },
          
          // Step 7
          {
            content : concat(
              "<p><mark>You're all done!</mark></p>",
              "<p>Hopefully you're a little more familiar with <mark>Prizzm</mark> now!</p>",
              "<p>Simply <mark>click this button</mark> to save your changes &amp; enjoy your stay!</p>"
            ),
            before : function (api, current, setup) {
             current.target = $('li.commit');
             setup.call();
            }
          },
        
      ]);
    },
    
    Stepper : Class.extend({
      
      init : function (id, startAt, steps) {
        $(document.body).qtip({
            id: id, // Give it an ID of ui-tooltip-step so we an identify it easily
            content: "initailizing..",
            position: {
               at : 'top center',
               my : 'bottom center',
               target: $('body'),
               viewport: $(window) // ...and make sure it stays on-screen if possible
            },
            show: {
               event: false, // Only show when show() is called manually
               ready: true // Also show on page load
            },
            hide: false, // Don't' hide unless we call hide()
            events: {
               render: function(event, api) {
                  // Grab tooltip element
                  var tooltip = api.elements.tooltip;

                  // Track the current step in the API
                  api.step = startAt - 1;

                  // Bind custom custom events we can fire to step forward/back
                  tooltip.bind('next prev', function(event) {
                     // Increase/decrease step depending on the event fired
                     api.step += event.type === 'next' ? 1 : -1;
                     api.step = Math.min(steps.length - 1, Math.max(0, api.step));

                     // Set new step properties
                     var current = steps[api.step];
                     if(current) {
                        var setup = function () {
                          api.set('content.text', current.content);
                          api.set('position.target', current.target);
                          api.set('position.my', current.my || 'bottom center');
                          api.set('position.at', current.at || 'top center');
                        }
                        
                        if(current.before) current.before.call(this, api, current, setup);
                        else setup.call(this);
                     }
                  });
                  
                  // Close event.
                  tooltip.bind('close', function (event) {
                    $(this).hide();
                  });
                  
                  // First Step..
                  $('#ui-tooltip-welcome-steps').triggerHandler('next');
               },

               // Destroy the tooltip after it hides as its no longer needed
               hide: function(event, api) { api.destroy(); }
            },
            
            // The style of the tooltip..
            style : 'ui-tooltip-tipsy ui-tooltip-shadow'
         });
      }
      
    })
    
  }
  
}