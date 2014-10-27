require 'rails_helper'

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

RSpec.describe ProductDiscountsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # ProductDiscount. As you add validations to ProductDiscount, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProductDiscountsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all product_discounts as @product_discounts" do
      product_discount = ProductDiscount.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:product_discounts)).to eq([product_discount])
    end
  end

  describe "GET show" do
    it "assigns the requested product_discount as @product_discount" do
      product_discount = ProductDiscount.create! valid_attributes
      get :show, {:id => product_discount.to_param}, valid_session
      expect(assigns(:product_discount)).to eq(product_discount)
    end
  end

  describe "GET new" do
    it "assigns a new product_discount as @product_discount" do
      get :new, {}, valid_session
      expect(assigns(:product_discount)).to be_a_new(ProductDiscount)
    end
  end

  describe "GET edit" do
    it "assigns the requested product_discount as @product_discount" do
      product_discount = ProductDiscount.create! valid_attributes
      get :edit, {:id => product_discount.to_param}, valid_session
      expect(assigns(:product_discount)).to eq(product_discount)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ProductDiscount" do
        expect {
          post :create, {:product_discount => valid_attributes}, valid_session
        }.to change(ProductDiscount, :count).by(1)
      end

      it "assigns a newly created product_discount as @product_discount" do
        post :create, {:product_discount => valid_attributes}, valid_session
        expect(assigns(:product_discount)).to be_a(ProductDiscount)
        expect(assigns(:product_discount)).to be_persisted
      end

      it "redirects to the created product_discount" do
        post :create, {:product_discount => valid_attributes}, valid_session
        expect(response).to redirect_to(ProductDiscount.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved product_discount as @product_discount" do
        post :create, {:product_discount => invalid_attributes}, valid_session
        expect(assigns(:product_discount)).to be_a_new(ProductDiscount)
      end

      it "re-renders the 'new' template" do
        post :create, {:product_discount => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested product_discount" do
        product_discount = ProductDiscount.create! valid_attributes
        put :update, {:id => product_discount.to_param, :product_discount => new_attributes}, valid_session
        product_discount.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested product_discount as @product_discount" do
        product_discount = ProductDiscount.create! valid_attributes
        put :update, {:id => product_discount.to_param, :product_discount => valid_attributes}, valid_session
        expect(assigns(:product_discount)).to eq(product_discount)
      end

      it "redirects to the product_discount" do
        product_discount = ProductDiscount.create! valid_attributes
        put :update, {:id => product_discount.to_param, :product_discount => valid_attributes}, valid_session
        expect(response).to redirect_to(product_discount)
      end
    end

    describe "with invalid params" do
      it "assigns the product_discount as @product_discount" do
        product_discount = ProductDiscount.create! valid_attributes
        put :update, {:id => product_discount.to_param, :product_discount => invalid_attributes}, valid_session
        expect(assigns(:product_discount)).to eq(product_discount)
      end

      it "re-renders the 'edit' template" do
        product_discount = ProductDiscount.create! valid_attributes
        put :update, {:id => product_discount.to_param, :product_discount => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested product_discount" do
      product_discount = ProductDiscount.create! valid_attributes
      expect {
        delete :destroy, {:id => product_discount.to_param}, valid_session
      }.to change(ProductDiscount, :count).by(-1)
    end

    it "redirects to the product_discounts list" do
      product_discount = ProductDiscount.create! valid_attributes
      delete :destroy, {:id => product_discount.to_param}, valid_session
      expect(response).to redirect_to(product_discounts_url)
    end
  end

end
