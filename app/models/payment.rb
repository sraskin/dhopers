class Payment < ActiveRecord::Base

  belongs_to :collector, class_name: 'User', foreign_key: :collected_by_id
  belongs_to :reviewer, class_name: 'User', foreign_key: :reviewed_by_id
  belongs_to :order

end
