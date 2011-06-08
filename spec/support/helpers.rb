
def rest_response url
  # https://github.com/archiloque/rest-client
  RestClient.get(url){|response, request, result| response }
end
