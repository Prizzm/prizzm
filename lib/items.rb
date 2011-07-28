#!/usr/bin/env ruby
require 'wrest'
require 'hashie'
require 'pp'
Hash.send :include, Hashie::HashExtensions

endpoint = "http://api.productwiki.com/connect/api.aspx?"
PRODUCTWIKI_API_KEY = "fcafd9a662de4b099e4815e5e77739f1"
data = []
items = %w(iphone tablet wii toyota guitar)
items.each do |item|
  response = endpoint.to_uri.get(:op => "search", :key => PRODUCTWIKI_API_KEY, :q => item).deserialise.to_mash
  results = response.pw_api_results.products.product
  pp results
  data << results
end

File.open('items.txt', 'w') do |f|
  f.puts Marshal.dump data.flatten
end
