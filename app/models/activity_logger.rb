class ActiveRecord::Base
  def to_notification
    attributes
  end
end

module ActivityLogger
  def self.method_missing method, *args
    if method =~ /^(\w+)/
      event = $1.gsub('_','.')
      log_event event, *args
    end
  end

  def self.log_event name, payload={}
    #  Calls the to_notification method on every ar item, and deletes nil
    #  attributes
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

