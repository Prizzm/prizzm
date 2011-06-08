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
    it {should have_many(:interactions).through(:items)}
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
      subject Factory :user_from_facebook 
      its(:photo) {should have_dimensions(50, 50)}
      
    end

    context "from a  Twitter account" do
      subject Factory :user_from_twitter 
      its(:photo) {should have_dimensions(50, 50)}
    end
  end

end
