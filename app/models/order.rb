class Order < ActiveRecord::Base

  include AASM

  belongs_to :user
  belongs_to :order_receiver, class_name: 'User', :foreign_key => :order_receiver_id

  has_many :order_events, dependent: :destroy
  has_many :payments, dependent: :nullify

  after_save :trigger_order_events
  after_save :send_order_notification
  before_create :generate_order_num

  ACCEPTED = :accepted
  REQUESTED = :requested
  COLLECTING = :collecting
  PROCESSING = :processing
  PROCESSED = :processed
  DELIVERED = :delivered
  COMPLETED = :completed
  CANCELLED = :cancelled

  ORDER_BASE_NUMBER = 10000

  aasm do
    state ACCEPTED, :initial => true
    state REQUESTED
    state COLLECTING
    state PROCESSING
    state PROCESSED
    state DELIVERED
    state COMPLETED
    state CANCELLED

    event :accept, :whiny_transitions => false do
      transitions :from => Order::REQUESTED, :to => Order::ACCEPTED
    end

    event :collect do
      transitions :from => Order::ACCEPTED, :to => Order::COLLECTING
    end

    event :process do
      transitions :from => Order::COLLECTING, :to => Order::PROCESSING
    end

    event :ready_for_delivery do
      transitions :from => Order::PROCESSING, :to => Order::PROCESSED
    end

    event :mark_as_delivered do
      transitions :from =>  Order::PROCESSED, :to => Order::DELIVERED
    end

    event :close do
      transitions :from => Order::DELIVERED, :to => Order::COMPLETED
    end

    event :cancel do
      transitions :from => Order::REQUESTED, :to => Order::CANCELLED
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

  def send_order_notification
    if self.aasm_state == Order::ACCEPTED.to_s
      OrderEventMailer.order_received(self, self.user)
    elsif self.aasm_state == Order::PROCESSED.to_s
      OrderEventMailer.order_processed(self, self.user)
    elsif self.aasm_state == Order::DELIVERED.to_s
       OrderEventMailer.order_delivery_notification(self, self.user)
       create_payment_history
    end
  end


  def create_payment_history
    self.payments.create!(
        {
            due:         true,
            amount:      self.amount,
            notes:        "Payment for Order##{self.order_number}",
            discount:    0,
            final_price: self.amount
        }
    )
  end

  # t.integer  "order_id",        limit: 4
  # t.boolean  "due",             limit: 1
  # t.float    "amount",          limit: 24
  # t.string   "notes",           limit: 255
  # t.integer  "collected_by_id", limit: 4
  # t.string   "number_of_items", limit: 255
  # t.float    "discount",        limit: 24
  # t.float    "final_price",     limit: 24
  # t.integer  "reviewed_by_id",  limit: 4
  # t.datetime "created_at",                  null: false
  # t.datetime "updated_at",

end
