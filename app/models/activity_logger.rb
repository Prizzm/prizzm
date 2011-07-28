class ActiveRecord::Base
  def to_notification
    attributes
  end
end

module ActivityLogger
  # This metaprogramming allows us to call arbitrary methods on teh
  # activityLogger module, and it converts these methodsd to an event name.
  # This allows us to make up names for events on the fly.  Whether or not that
  # is a good idea is another discussion.
  def self.method_missing method, *args
    if method =~ /^(\w+)/
      event = $1.gsub('_','.')
      log_event event, *args
    end
  end

  def self.log_event name, payload={}
    #  Calls the to_notification method on every ar item, and deletes nil
    #  attributes
    #  all ar obects have a to_notification method defined by default, as it is
    #  loaded at the top of this file 
    payload.each do |key,value|
      begin
        object = value.to_notification.delete_if{|k,v| v.nil?}
        object.delete "created_at"
        object.delete "updated_at"
        payload[key] = object
      rescue NoMethodError
        payload[key] = value
      end
    end 
    log =  {:event => name, :time => Time.now.to_i}.merge(payload)
    Notification.create(log)
  end
end

