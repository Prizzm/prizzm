# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

def make_real user
  10.times do
    item = Factory.build :item
    user.items << item
    3.times do
      item.interactions << Factory.build(:interaction)
    end
  end
  user.save
end

# create a test user
sidney = Factory :user, {:email => 'sid137@gmail.com', :password => 'password', :profile => Factory(:profile, {:first_name => 'Sidney', :last_name => 'Burks'}) } 
test = Factory :user, {:email => 'test@test.com', :password => 'password', :profile => Factory(:profile, {:first_name => 'Test', :last_name => 'User'}) } 
sidney.make_real
test.make_real

