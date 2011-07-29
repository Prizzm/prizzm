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
    user = payload[:from]
    from = {:class => user.class.to_s, :id => user.id, :name => user.name}

    #  force objects into 1-level array, remove [nil] if no :for is specified
    source_user = [payload[:from]]
    targets = (source_user + [payload[:for]].flatten.reject{ |i| i.nil?}).uniq
    dest = targets.collect do |o|
      {:class => o.class.to_s, :id => o.id }
    end

    # add target objects to data array, but remove duplication

    payload_data = [payload[:data]].flatten.reject{ |i| i.nil?}
    data = (targets - source_user + payload_data).uniq
    info = data.collect do |object|
      begin
        doc = object.to_notification.delete_if{|k,v| v.nil?}
        doc.delete "created_at"
        doc.delete "updated_at"
        doc.reverse_merge!(:class => object.class.to_s)
      rescue NoMethodError
        object   # TODO: figure out what to do for this case
      end
    end 
    payload = {:from => from, :about => dest, :data => info}
    log =  {:event => name, :time => Time.now.to_i}.merge(payload)
    Notification.create(log)

    # TODO: Put all of the following in a background task
    #Resque.enqueue "something"

    # find subscribers to this event
    #log = Notification.last
    subscriber_ids = log[:about].collect do |object|
      subscriptions = Subscription.where(:subscribable_type => object[:class], :subscribable_id => object[:id]).all
      subscriptions.collect {|s| s.user_id }
    end
    subscriber_ids = subscriber_ids.flatten.uniq
    
    #  deliver message to subscribers feeds
    subscriber_ids.each do |sid|
      user_stream = Stream.where(:user_id => sid).first
      user_stream.add_to_set(:feed, log)
    end
    
    # TODO:  Do other event ddependant things - sending email, etc..?
    case log[:event] 
    when "user.rate.item"
    when "user.update.profile"
    end

  end
end

