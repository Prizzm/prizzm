# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# create a test user


def make_real user
  8.times do
    item = Factory :item_with_images
    user.items << item
  end
end

#sidney = Factory :user, {:email => 'sid137@gmail.com', :password => 'password', :profile => Factory(:profile, {:first_name => 'Sidney', :last_name => 'Burks'}) } 
#make_real sidney

#test = Factory :user, {:email => 'test@test.com', :password => 'password', :profile => Factory(:profile, {:first_name => 'Test', :last_name => 'User'}) } 
#make_real test

1000.times { Factory :user }

bryna_nicole = Company.create({
  :name => "Bryna Nicole", 
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

bryna2.add_image_from_url "http://shopbryna.com/store/media/catalog/product/h/e/hermann-mini_cream-ikat.jpg"
bryna2.add_image_from_url "http://shopbryna.com/store/media/catalog/product/h/e/hermann-mini_multi-ikat_1.jpg"
bryna2.add_image_from_url "http://shopbryna.com/store/media/catalog/product/f/i/file_7_1.jpg"
bryna2.add_image_from_url "http://shopbryna.com/store/media/catalog/product/f/i/file_8_1.jpg"


bryna_nicole.products << [bryna1, bryna2]
