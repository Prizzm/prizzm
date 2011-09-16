module ApplicationHelper
  def html_clean string
    return raw sanitize string,
                        :tags       => ['a', 'b', 'blockquote', 'i', 'img', 'u', 'ul', 'ol', 'li', 'p', 's', 'strike', 'strong'],
                        :attributes => ['alt', 'class', 'height', 'href', 'id', 'src', 'style', 'title' 'width'],
                        :protocols  => {
                          'a'   => {
                            'href' => ['http', 'https', 'mailto']
                          },
                          'img' => {
                            'src' => ['http', 'https']
                          }
                        }
  end

  def format string
    return string.gsub(/\n/, '<br>')
                 .gsub(/(<?= ) /, '&nbsp;');
  end
end
