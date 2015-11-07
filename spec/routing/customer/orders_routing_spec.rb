require "rails_helper"

RSpec.describe Customer::OrdersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/customer/orders").to route_to("customer/orders#index")
    end

    it "routes to #new" do
      expect(:get => "/customer/orders/new").to route_to("customer/orders#new")
    end

    it "routes to #show" do
      expect(:get => "/customer/orders/1").to route_to("customer/orders#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/customer/orders/1/edit").to route_to("customer/orders#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/customer/orders").to route_to("customer/orders#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/customer/orders/1").to route_to("customer/orders#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/customer/orders/1").to route_to("customer/orders#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/customer/orders/1").to route_to("customer/orders#destroy", :id => "1")
    end

  end
end
