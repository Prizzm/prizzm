module ApplicationHelper
  def format string
    return string.gsub(/\n/, '<br>')
                 .gsub(/(<?= ) /, '&nbsp;');
  end
end
