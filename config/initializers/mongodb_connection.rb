module CachedMongoDBConnection

  def mongodb_connection
    uri ||= URI.parse(ENV['MONGOHQ_URL'])
    #conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    @@cached_mongodb_connection ||= Mongo::Connection.from_uri(ENV['MONGOHQ_URL']).db(uri.path.gsub(/^\//, ''))
  end

end