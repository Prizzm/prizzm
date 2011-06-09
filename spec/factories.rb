require 'open-uri'
require 'nokogiri'

TEST_PRODUCTS = Marshal.load File.read(File.join(Rails.root, 'lib', 'items.txt'))


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


Factory.define :product do |product|
  product.upc
  product.rating { [1,2,3].rand }
  product.after_create do |p|
    test_product = TEST_PRODUCTS.rand
    p.product_type = test_product.category
    p.name = test_product.title #using the 'randexp' gem to create a random realistic sounding word, using a Regexp
    p.url = test_product.url
    desc = Nokogiri::HTML(open(p.url)).at_css('#wc-condensed')
    p.description = desc.text unless desc.nil?
    p.add_image_from_url test_product.images.image.largeimage
  end
end 



Factory.define :profile do |profile|
  profile.first_name { Forgery::Name.first_name }
  profile.last_name { Forgery::Name.last_name }
  profile.phone_number { Forgery::Address.phone }
  profile.location { Forgery::Address.street_address }
end 

Factory.define :user do |user|
  user.email { Forgery::Internet.email_address }
  user.password {Forgery::Basic.password }
  user.password_confirmation {|u| u.password }
  user.association :profile
end 


# Table name: items
Factory.define :item do |item|
  item.rating { [1,2,3].rand }
  item.review
  item.sku
end

Factory.define :item_with_images, :parent => :item do |item|
  item.after_create do |i|
    2.times do
      i.add_image_from_url "http://www.google.com/images/logos/ps_logo2.png" 
    end
  end
end 

Factory.define :interaction do |interaction|
  interaction.time_start { Random.date.to_datetime}
  interaction.time_end { |i| i.time_start + 1.day }
  interaction.contact { ["Email", "Phone", "Prizzm", "Video"].random }
  interaction.description { Faker::Company.bs }
  interaction.rating { [1,2,3].rand }
end


