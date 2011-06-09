require 'spec_helper'

describe User do
  describe "model attributes" do
    it "should be tested by devise itself" do
    end
  end

  describe "associations" do
    it {should have_one(:profile)}
    it {should have_many(:items)}
    it {should have_many(:products).through(:items)}
  end

  describe "attributes" do
    
    context "mass assignment" do
      it {should allow_mass_assignment_of(:email)} 
      it {should allow_mass_assignment_of(:photo)} 
      it {should allow_mass_assignment_of(:password)} 
      it {should allow_mass_assignment_of(:password_confirmation)} 
      it {should allow_mass_assignment_of(:remember_me)} 
      it {should allow_mass_assignment_of(:first_name)} 
      it {should allow_mass_assignment_of(:last_name)} 
      it {should allow_mass_assignment_of(:phone_number)} 
      it {should allow_mass_assignment_of(:location)} 
      it {should allow_mass_assignment_of(:access_token)} 
      
      describe "of association attributes" do
         it {should allow_mass_assignment_of(:profile_attributes)} 
      end
    end
  end

  describe "when creating" do
    context "from a Facebook account" do
      it "should be able to create a new user in Prizzm from a Facebook account" do
        user_hash = FB_TEST_HASH 
        user_email = user_hash['user_info']['email']
        User.find_by_email(user_email).should be_nil
        user = User.find_for_facebook_oauth(user_hash)
        User.find_by_email(user_email).should == user
      end

      it "should have a photo of size 50x50" do 
        new_fb_user.photo.should have_dimensions(50, 50)
      end 
    end

    context "from a  Twitter account" do
      it "should be able to create a new user in Prizzm from a Twitter account" do
        user_hash = TWITTER_TEST_HASH 
        credentials = user_hash['credentials']
        info = user_hash['user_info']
        User.find_by_tt_token_and_tt_secret(credentials['token'], credentials['secret']).should be_nil
        user = User.find_for_twitter_oauth(user_hash)
        User.find_by_tt_token_and_tt_secret(credentials['token'], credentials['secret']).should == user
      end

      it "should have a photo of size 50x50" do 
        new_twitter_user.photo.should have_dimensions(50, 50)
      end 
    end
  end

end
