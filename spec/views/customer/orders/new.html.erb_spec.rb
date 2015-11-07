require 'rails_helper'

RSpec.describe "customer/orders/new", type: :view do
  before(:each) do
    assign(:customer_order, Customer::Order.new())
  end
end
