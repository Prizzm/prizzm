#!/usr/bin/env ruby
require 'wrest'
require 'hashie'
require 'nokogiri'
require 'pp'
require 'open-uri'
Hash.send :include, Hashie::HashExtensions

endpoint = "http://api.productwiki.com/connect/api.aspx?"
PRODUCTWIKI_API_KEY = "fcafd9a662de4b099e4815e5e77739f1"
data = []
items = %w(iphone tablet wii toyota guitar)
#items = %w(iphone)
items.each do |item|
  response = endpoint.to_uri.get(:op => "search", :key => PRODUCTWIKI_API_KEY, :q => item).deserialise.to_mash
  results = response.pw_api_results.products.product
  results.each do |result|
    # Download images to local file
    image_url = URI.parse result.images.image.rawimage
    filename = File.basename image_url.path
    `cd images; curl -O #{image_url}`
    result.image_filename = filename

    # Scrape description from website
    desc = Nokogiri::HTML(open(result.url)).at_css('#wc-condensed')
    result.description = desc.nil? ? "" : desc.text
  end
  pp results
  data << results
end

File.open('items.txt', 'w') do |f|
  f.puts Marshal.dump data.flatten
end
