
def rest_response url
  # https://github.com/archiloque/rest-client
  RestClient.get(url){|response, request, result| response }
end

def should_be_hidden text, selector=''
  wait_until do
    sleep 4
    true
  end
  wait_until do
    page.evaluate_script('$.active') == 0
    its_hidden = page.evaluate_script("$('#{selector}:contains(#{text})').is(':hidden');")
    its_not_in_dom = page.evaluate_script("$('#{selector}:contains(#{text})').length == 0;")
    puts "Is hidden #{its_hidden}"
    puts "Is not in dom: #{its_not_in_dom}"
    (its_hidden || its_not_in_dom).should be_true
  end
end
