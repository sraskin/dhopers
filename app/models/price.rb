class Price < ActiveRecord::Base
  # t.string   "name",               limit: 255
  # t.integer  "dry_cleaning_price", limit: 4
  # t.integer  "laundry_price",      limit: 4

  validates :name, :dry_cleaning_price, :laundry_price, :presence => true
end
