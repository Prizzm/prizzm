RANDOM = { :users => 20, :items => 8, :products => 5 }

def set_follows user, type=:users
  klass = type.to_s.classify.constantize
  random_objects = klass.random RANDOM[type] 
  random_objects.each do |object|
    with_probability(0.5) { user.follow object }
    with_probability(0.5) { object.follow user if type == :users }
  end 
end 

def add_real_items_for user
  RANDOM[:items].times do
    item = Factory :item_with_images
    with_probability(0.7) { item.privacy = 'public' }
    user.items << item
  end
end

def add_default_items_for user
  RANDOM[:items].times do
    item = Factory :item
    with_probability(0.7) { item.privacy = 'public' }
    user.items << item
  end
end

# Do something sometimes (with probability p).
def with_probability(p, &block)
  yield(block) if rand <= p
end
alias :sometimes :with_probability
