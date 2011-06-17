
def rest_response url
  # https://github.com/archiloque/rest-client
  RestClient.get(url){|response, request, result| response }
end

def should_be_hidden text, selector=''
  sleep Capybara.default_wait_time
  its_hidden = page.evaluate_script("$('#{selector}:contains(#{text})').is(':hidden');")
  its_not_in_dom = page.evaluate_script("$('#{selector}:contains(#{text})').length == 0;")
  (its_hidden || its_not_in_dom).should be_true
end
