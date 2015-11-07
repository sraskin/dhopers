require 'rails_helper'

RSpec.describe Customer::OrdersController, type: :controller do

  let(:customer) { create(:user) }

  before do
    sign_in customer
  end

  # This should return the minimal set of attributes required to create a valid
  # Order. As you add validations to Order, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:order)
  }

  let(:invalid_attributes) {
    {}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OrdersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    let(:orders) { create_list(:order, 10, user: customer) }

    before do
      get :index, {}, valid_session
    end

    it "assigns all customer_orders as @customer_orders" do
      expect(assigns(:customer_orders)).to eq(orders)
    end
  end

  describe "GET #show" do
    let(:order) { create(:order) }

    before do
      get :show, {:id => order.to_param}, valid_session
    end

    it "assigns the requested customer_order as @customer_order" do
      expect(assigns(:customer_order)).to eq(order)
    end

  end

  describe "GET #new" do
    before do
      get :new, {}, valid_session
    end

    it "assigns a new customer_order as @customer_order" do
      expect(assigns(:customer_order)).to be_a_new(Order)
    end
  end

  describe "GET #edit" do
    let(:order) { create(:order) }

    before do
      get :edit, {:id => order.to_param}, valid_session
    end

    it "assigns the requested customer_order as @customer_order" do
      expect(assigns(:customer_order)).to eq(order)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Order" do
        expect {
          post :create, {:customer_order => valid_attributes}, valid_session
        }.to change(Order, :count).by(1)
      end

      it "assigns a newly created customer_order as @customer_order" do
        post :create, {:customer_order => valid_attributes}, valid_session
        expect(assigns(:customer_order)).to be_a(Order)
        expect(assigns(:customer_order)).to be_persisted
      end

      it "redirects to the created customer_order" do
        post :create, {:customer_order => valid_attributes}, valid_session
        expect(response).to redirect_to(customer_order_path(Order.last))
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:order)
      }

      let!(:order) { create(:order) }

      it "updates the requested customer_order" do
        put :update, {:id => order.to_param, :customer_order => new_attributes}, valid_session
        order.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested customer_order as @customer_order" do
        put :update, {:id => order.to_param, :customer_order => valid_attributes}, valid_session
        expect(assigns(:customer_order)).to eq(order)
      end

    end
  end

  describe "DELETE #destroy" do
    let!(:order) { create(:order) }

    it "destroys the requested customer_order" do
      expect {
        delete :destroy, {:id => order.to_param}, valid_session
      }.to change(Order, :count).by(-1)
    end

    it "redirects to the customer_orders list" do
      delete :destroy, {:id => order.to_param}, valid_session
      expect(response).to redirect_to(customer_orders_url)
    end
  end

end
