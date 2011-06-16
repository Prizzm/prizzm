require 'spec_helper'

describe Item do
  describe "model attributes" do
    it {should have_db_column(:name).of_type(:string)}
    it {should have_db_column(:privacy).of_type(:string)}
    it {should have_db_column(:review).of_type(:text)}
    it {should have_db_column(:rating).of_type(:integer)}
  end

  describe "associations" do
    it {should belong_to(:product)}
    it {should belong_to(:user)}
    it {should have_many(:images).dependent(:destroy)}
    it {should have_many(:interactions).dependent(:destroy)}
  end

  context "attribute defaults" do
    its(:privacy) {should eq('private')} 
  end

  context "when creating associated objects" do
    before :each do
      @item = Factory.build :item
    end
    
    it "should be able to add an interaction" do
      @interaction = Factory.build :interaction
      params = {:item => @item.attributes.merge(:interactions_attributes  => [@interaction.attributes]) }
      @saved_item = Item.create(params[:item])
      @saved_item.should have(1).interaction
      @saved_item.interactions.first.should_not be_new_record
    end

    it "should be able to add images" do
      pending "tests"
      item_image = Factory.build :item_image
      params = {:item => @item.attributes.merge(:images_attributes  => [item_image.attributes]) }
      @saved_item = Item.create(params[:item])
      @saved_item.should have(1).image
      @saved_item.images.should_not be_new_record
    end
  end
      
  context "convenience methods" do
    before :each do
      @item = Factory :item
      @product = Factory :product
      @product.items << @item
    end

    context "items associated with a product" do
      it "should respond to 'has_product? with a boolean'" do
        @item.has_product?.should be_true
      end

      it "should respond to 'parent_company' with a Company" do
        @item.parent_company.should eq(@product.company)
      end
    end
  end
end
