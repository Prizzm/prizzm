module JavascriptHelper

  def enable_editor
    render 'javascript/editor'
  end

  
  def show_stars_for element
    %Q{
    <script>
      $(document).ready(function(){
        $("#{element}").stars({
          inputType: "select",
          cancelShow: false
        });
      });
    </script>
    }.gsub(/[\n ]+/, ' ').strip.html_safe
  end

  def photo_uploadify
    # Putting the uploadify trigger script in the helper gives us
    # full access to the view and native rails objects without having
    # to set javascript variables.
    #
    # Uploadify is only a queue manager to hand carrierwave the files
    # one at a time. Carrierwave handles capturing, resizing and saving
    # all uploads. All limits set here (file types, size limit) are to
    # help the user pick the right files. Carrierwave is responsible
    # for enforcing the limits (white list file name, setting maximum file sizes)
    #
    # ScriptData:
    #   Sets the http headers to accept javascript plus adds
    #   the session key and authenticity token for XSS protection.
    #   The "FlashSessionCookieMiddleware" rack module deconstructs these 
    #   parameters into something Rails will actually use.

    session_key_name = Rails.application.config.session_options[:key]
    content_for :jquery do
      %Q{

      <script type='text/javascript'>
        $(document).ready(function() {
          $('input#item_image_image').uploadify({
            script : '#{item_images_path(@item)}',
            fileDataName    : 'image[image]',
            uploader        : '/assets/uploadify.swf',
            cancelImg       : '/images/cancel.png',
            fileDesc        : 'Images',
            fileExt         : '*.png;*.jpg;*.gif;*.JPG',
            sizeLimit       : #{10.megabytes},
            queueSizeLimit  : 24,
            multi           : true,
            auto            : true,
            buttonText      : 'ADD IMAGES',
            scriptData      : {
              '_http_accept': 'application/javascript',
              '#{session_key_name}' : encodeURIComponent('#{u(cookies[session_key_name])}'),
              'authenticity_token'  : encodeURIComponent('#{u(form_authenticity_token)}')
            },
            onOpen          : function() {
              $('#addimage-loader').css('display', 'inline-block');
              $('#item_image_imageQueue').css('display', 'inline-block');
            },
            onComplete      : function(event, id, object, response, data){ 
              $('body').trigger('insertImage', response);
              $('#addimage-loader').css('display', 'none');
            }
          });
        });
      </script>

      }.gsub(/[\n ]+/, ' ').strip.html_safe
    end
  end
end
