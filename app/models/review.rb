class Review < ActiveRecord::Base

  include AASM

  belongs_to :order
  belongs_to :user
  belongs_to :reviewed, :class_name => 'User', foreign_key: :reviewed_by_id

  OPENED  = :open
  CLOSED  = :close
  ABORTED = :aborted

  REVIEW_ITEMS = {
      :overall         => 0,
      :delivery_man    => 1,
      :service_quality => 2
  }

  validates :reviewed_on, :presence => true

  aasm do
    state OPENED, :initial => true
    state CLOSED
    state ABORTED

    event :close, :whiny_transitions => false do
      transitions :from => OPENED, :to => CLOSED
    end

    event :abort, :whiny_transitions => false do
      transitions :from => [OPENED, CLOSED], :to => ABORTED
    end
  end

end
