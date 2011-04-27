
Factory.define :profile do |profile|
  profile.first_name { Forgery::Name.first_name }
  profile.last_name { Forgery::Name.last_name }
  profile.phone_number { Forgery::Address.phone }
  profile.location { Forgery::Address.street_address }
  profile.photo_url {"http://lorempixum.com/200/200/people/" + (1..10).to_a.rand.to_s }
end 

Factory.define :user do |user|
  user.email { Forgery::Internet.email_address }
  user.password {Forgery::Basic.password }
  user.password_confirmation {|u| u.password }
  user.association :profile
end 


Factory.define :item do |item|
  item.name { /\w+/.gen } #using the 'randexp' gem to create a random realistic sounding word, using a Regexp
  item.url {"http://www.#{Forgery::Internet.domain_name}"}
  item.description { Faker::Company.catch_phrase}
  item.itemtype { Faker::Company.bs }
  item.rating { [1,2,3,4,5].rand }
end 

Factory.define :interaction do |interaction|
  interaction.time_start { Random.date.to_datetime}
  interaction.time_end { |i| i.time_start + 1.day }
  interaction.contact { ["email", "phone", "pigeon"].random }
  interaction.description { Faker::Company.bs }
  interaction.rating { [1,2,3,4,5].rand }
end

