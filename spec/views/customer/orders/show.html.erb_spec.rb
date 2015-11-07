require 'rails_helper'

RSpec.describe "customer/orders/show", type: :view do
  before(:each) do
    @customer_order = assign(:customer_order, create(:order))
  end
end
