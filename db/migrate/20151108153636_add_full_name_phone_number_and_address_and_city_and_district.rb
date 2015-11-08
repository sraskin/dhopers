class AddFullNamePhoneNumberAndAddressAndCityAndDistrict < ActiveRecord::Migration
  def change
    add_column :orders, :full_name, :string
    add_column :orders, :email, :string
    add_column :orders, :phone, :string
    add_column :orders, :address, :string
    add_column :orders, :city, :string, default: 'Dhaka'
    add_column :orders, :country, :string, default: 'Bangladesh'
    add_column :orders, :post, :string
  end
end
