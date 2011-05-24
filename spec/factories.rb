require 'open-uri'
require 'nokogiri'

TEST_ITEMS = Marshal.load File.read(File.join(Rails.root, 'lib', 'items.txt'))


# Company with all attributes filled in
Factory.define :company do |company|
  company.email { Forgery::Internet.email_address }
  company.address { Forgery::Address.street_address }
  company.phone_number { Forgery::Address.phone }
  company.secondary_number { Forgery::Address.phone }
  company.contact_name { "#{Forgery::Name.first_name} #{Forgery::Name.last_name}" }
  company.industry { %w(Technology Fashion Health Art Science Business).rand }
  company.url {"http://www.#{Forgery::Internet.domain_name}"}
end 

# Create a company with a random number of images.  We used a fixed image with a
# file extension, due to a Carrierwave bug
Factory.define :company_with_images, :parent => :company do |company|
  company.after_create do |c|
    #(1..5).random.times do
    2.times do
      c.add_image_from_url "http://www.google.com/images/logos/ps_logo2.png" 
      #c.add_image_from_url "http://lorempixum.com/600/600" 
    end
  end 
end 





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


# Table name: items
Factory.define :item do |item|
  item.itemtype { Faker::Company.bs }
  item.facebook
  item.twitter
  item.rating { [1,2,3].rand }
  item.after_build do |i|
    test_item = TEST_ITEMS.rand
    i.industry = test_item.category
    i.name = test_item.title #using the 'randexp' gem to create a random realistic sounding word, using a Regexp
    i.url = test_item.url
    i.description = Nokogiri::HTML(open(i.url)).at_css('#wc-condensed').text
    i.add_image_from_url test_item.images.image.largeimage
  end
end 

Factory.define :interaction do |interaction|
  interaction.time_start { Random.date.to_datetime}
  interaction.time_end { |i| i.time_start + 1.day }
  interaction.contact { ["Email", "Phone", "Prizzm", "Video"].random }
  interaction.description { Faker::Company.bs }
  interaction.rating { [1,2,3].rand }
end

