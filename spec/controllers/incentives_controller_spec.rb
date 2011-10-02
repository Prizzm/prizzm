require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe IncentivesController do

  # This should return the minimal set of attributes required to create a valid
  # Incentive. As you add validations to Incentive, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all incentives as @incentives" do
      incentive = Incentive.create! valid_attributes
      get :index
      assigns(:incentives).should eq([incentive])
    end
  end

  describe "GET show" do
    it "assigns the requested incentive as @incentive" do
      incentive = Incentive.create! valid_attributes
      get :show, :id => incentive.id.to_s
      assigns(:incentive).should eq(incentive)
    end
  end

  describe "GET new" do
    it "assigns a new incentive as @incentive" do
      get :new
      assigns(:incentive).should be_a_new(Incentive)
    end
  end

  describe "GET edit" do
    it "assigns the requested incentive as @incentive" do
      incentive = Incentive.create! valid_attributes
      get :edit, :id => incentive.id.to_s
      assigns(:incentive).should eq(incentive)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Incentive" do
        expect {
          post :create, :incentive => valid_attributes
        }.to change(Incentive, :count).by(1)
      end

      it "assigns a newly created incentive as @incentive" do
        post :create, :incentive => valid_attributes
        assigns(:incentive).should be_a(Incentive)
        assigns(:incentive).should be_persisted
      end

      it "redirects to the created incentive" do
        post :create, :incentive => valid_attributes
        response.should redirect_to(Incentive.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved incentive as @incentive" do
        # Trigger the behavior that occurs when invalid params are submitted
        Incentive.any_instance.stub(:save).and_return(false)
        post :create, :incentive => {}
        assigns(:incentive).should be_a_new(Incentive)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Incentive.any_instance.stub(:save).and_return(false)
        post :create, :incentive => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested incentive" do
        incentive = Incentive.create! valid_attributes
        # Assuming there are no other incentives in the database, this
        # specifies that the Incentive created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Incentive.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => incentive.id, :incentive => {'these' => 'params'}
      end

      it "assigns the requested incentive as @incentive" do
        incentive = Incentive.create! valid_attributes
        put :update, :id => incentive.id, :incentive => valid_attributes
        assigns(:incentive).should eq(incentive)
      end

      it "redirects to the incentive" do
        incentive = Incentive.create! valid_attributes
        put :update, :id => incentive.id, :incentive => valid_attributes
        response.should redirect_to(incentive)
      end
    end

    describe "with invalid params" do
      it "assigns the incentive as @incentive" do
        incentive = Incentive.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Incentive.any_instance.stub(:save).and_return(false)
        put :update, :id => incentive.id.to_s, :incentive => {}
        assigns(:incentive).should eq(incentive)
      end

      it "re-renders the 'edit' template" do
        incentive = Incentive.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Incentive.any_instance.stub(:save).and_return(false)
        put :update, :id => incentive.id.to_s, :incentive => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested incentive" do
      incentive = Incentive.create! valid_attributes
      expect {
        delete :destroy, :id => incentive.id.to_s
      }.to change(Incentive, :count).by(-1)
    end

    it "redirects to the incentives list" do
      incentive = Incentive.create! valid_attributes
      delete :destroy, :id => incentive.id.to_s
      response.should redirect_to(incentives_url)
    end
  end

end