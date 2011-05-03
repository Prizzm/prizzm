#!/usr/bin/env ruby
require 'wrest'
require 'pp'

endpoint = "http://api.productwiki.com/connect/api.aspx?"
PRODUCTWIKI_API_KEY = "fcafd9a662de4b099e4815e5e77739f1"

results = endpoint.to_uri.get(:op => "search", :key => PRODUCTWIKI_API_KEY, :q => 'iphone').deserialise


pp results
