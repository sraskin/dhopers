class Order < ActiveRecord::Base

  include AASM

  belongs_to :user
  belongs_to :order_receiver, class_name: 'User', :foreign_key => :order_receiver_id

  has_many :order_events, dependent: :destroy

  after_save :trigger_order_events
  before_create :generate_order_num

  ACCEPTED = :accepted
  REQUESTED = :requested
  COLLECTING = :collecting
  PROCESSING = :processing
  DELIVERED = :delivered
  COMPLETED = :completed
  CANCELLED = :cancelled

  ORDER_BASE_NUMBER = 10000

  aasm do
    state ACCEPTED, :initial => true
    state REQUESTED
    state COLLECTING
    state PROCESSING
    state DELIVERED
    state COMPLETED
    state CANCELLED

    event :accept, :whiny_transitions => false do
      transitions :from => :requested, :to => :accepted
    end

    event :collect do
      transitions :from => :accepted, :to => :collecting
    end

    event :process do
      transitions :from => :collecting, :to => :processing
    end

    event :deliver do
      transitions :from => :processing, :to => :delivered
    end

    event :close do
      transitions :from => :delivered, :to => :completed
    end

    event :cancel do
      transitions :from => :requested, :to => :cancel
    end

  end

  def trigger_order_events
    self.order_events.create!(current_state: self.aasm_state, previous_state: self.aasm_state_was || 'requested' ,user: self.user)
  end

  private

  def generate_order_num
    self.order_number = get_order_number
  end

  def get_order_number
    "#{Order::ORDER_BASE_NUMBER + Order.maximum(:id).to_i.next}"
  end

end
