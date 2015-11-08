class ChangeColumnInReview < ActiveRecord::Migration
  def change
    change_column :reviews, :reviewed_on, :integer, default: 0
    add_column :reviews, :aasm_state, :string
  end
end
