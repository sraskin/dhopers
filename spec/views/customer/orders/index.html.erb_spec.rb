require 'rails_helper'

RSpec.describe "customer/orders/index", type: :view do
  before(:each) do
    assign(:customer_orders, create_list(:order, 10))
  end

  it "renders a list of customer/orders" do
    render
  end
end
