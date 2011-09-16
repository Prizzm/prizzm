
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# create a test user
#
#  Functions defined in lib/deefinitions/test_data.rb

User.destroy_all
Product.destroy_all
Company.destroy_all
Notification.destroy_all

# These should be destroyed by the above, but I will leave the explicit destroys
# here for now until I can proove it
Item.destroy_all
Comment.destroy_all
Follow.destroy_all
Case.destroy_all
Stream.destroy_all
Subscription.destroy_all 



bryna_nicole = Company.create({
  :name => "BRYNA", 
  :email => "bryna@prizzm.com",
  :url => "http://shopbryna.com/",
  :phone_number => "877-294-BAGS (6047)",
  :industry => "Fashion",
  :contact_name => "Bryna Nicole"
})

bryna_nicole.add_image_from_url "http://shopbryna.com/images/logo.gif"

bryna1 = Product.create({
  :product_type => 'Hand Bag',
  :rating => 3,
  :name  => 'Serrano Hobo',
  :url  => 'http://shopbryna.com/store/serrano-hobo-ikat.html',
  :price => '$295.00',
  :description  => "The Serrano hobo is updated for Summer with lightweight colorful ikat printed cotton imported from India. With leather trim handles and side gusset, the Ikat Serrano is your best bet for an all-around stylish summer hobo.  Kangaroo pockets on front and back as well as 3 interior pockets keep you organized. Lined in 100% cotton print and made of 100% italian leather."
})

bryna1.add_image_from_url "http://shopbryna.com/store/media/catalog/product/s/e/serrano_navy_1.jpg"
bryna1.add_image_from_url "http://shopbryna.com/store/media/catalog/product/s/e/serrano_-cream-ikat.jpg"
bryna1.add_image_from_url "http://shopbryna.com/store/media/catalog/product/s/e/serrano_tan_1.jpg"
bryna1.add_image_from_url "http://shopbryna.com/store/media/catalog/product/f/i/file_8_2.jpg"
bryna1.add_image_from_url "http://shopbryna.com/store/media/catalog/product/f/i/file_7_2.jpg"



bryna2 = Product.create({
  :product_type => 'Hand Bag',
  :rating => 3,
  :name  => 'Hermann Mini',
  :url  => 'http://shopbryna.com/store/hermann-mini.html',
  :price => '$158.00',
  :description  => "The newest cross-body bag for the summer - the Hermann Mini was born from the Hermann School bag and features the same antique brass hardware. This bag is a great day bag to hold just the bare essentials. The messenger strap with a 22\" drop gives you a hands-free option when you're on the go."
})

bryna2.add_image_from_url "http://shopbryna.com/store/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/h/e/hermann_mini_blk_lamb.jpg"
bryna2.add_image_from_url "http://shopbryna.com/store/media/catalog/product/h/e/hermann-mini_cream-ikat.jpg"
bryna2.add_image_from_url "http://shopbryna.com/store/media/catalog/product/h/e/hermann-mini_multi-ikat_1.jpg"
bryna2.add_image_from_url "http://shopbryna.com/store/media/catalog/product/f/i/file_7_1.jpg"
bryna2.add_image_from_url "http://shopbryna.com/store/media/catalog/product/f/i/file_8_1.jpg"


bryna_nicole.products << [bryna1, bryna2]









sidney = Factory :user, {:email => 'sid137@gmail.com', :password => 'password', :first_name => 'Sidney', :last_name => 'Burks'}
test = Factory :user, {:email => 'test@test.com', :password => 'password', :first_name => 'Test', :last_name => 'User'}
test1 = Factory :user, {:email => 'test@prizzm.com', :password => 'password', :first_name => 'Test', :last_name => 'Prizzm'}
test2 = Factory :user, {:email => 'test2@prizzm.com', :password => 'password', :first_name => 'Test2', :last_name => 'Prizzm'}
test3 = Factory :user, {:email => 'test3@prizzm.com', :password => 'password', :first_name => 'Test3', :last_name => 'Prizzm'}

if ENV['PUSH_DEMO'] == true
  numb = 4
else
  numb = 30
end


numb.times do
  user = Factory :user 
  user.follow bryna_nicole
  user.follow bryna1
  user.follow bryna2
  add_real_items_for user
end


set_follows sidney
sidney.follow bryna1
sidney.follow bryna2
sidney.follow bryna_nicole
sidney.follow test
add_real_items_for sidney

set_follows test
test.follow bryna1
test.follow bryna2
test.follow bryna_nicole
test.follow sidney
add_real_items_for test

