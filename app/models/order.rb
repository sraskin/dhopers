class Order < ActiveRecord::Base

  include AASM

  belongs_to :user
  belongs_to :order_receiver, class_name: 'User', :foreign_key => :order_receiver_id

  has_many :order_events, dependent: :destroy
  has_many :payments, dependent: :nullify

  after_save :trigger_order_events
  before_create :generate_order_num

  after_save do
    self.send_order_notification
  end

  validates :phone, :presence => true

  ACCEPTED   = :accepted
  REQUESTED  = :requested
  COLLECTING = :collecting
  PROCESSING = :processing
  PROCESSED  = :processed
  DELIVERED  = :delivered
  COMPLETED  = :completed
  CANCELLED  = :cancelled

  ORDER_BASE_NUMBER = 10000

  aasm do
    state REQUESTED, :initial => true
    state ACCEPTED
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
      transitions :from => Order::PROCESSED, :to => Order::DELIVERED
    end

    event :close do
      transitions :from => Order::DELIVERED, :to => Order::COMPLETED
    end

    event :cancel do
      transitions :from => Order::REQUESTED, :to => Order::CANCELLED
    end

  end

  def assign_user_information
    self.full_name = self.user.full_name
    self.email     = self.user.email
  end

  def to_param
    self.order_number
  end

  def order_path
    Rails.application.routes.url_helpers.customer_order_url(self)
  end

  def order_sms_txt
    if self.aasm_state == Order::ACCEPTED.to_s
      return "Your requested order(#{self.order_number}) has been accepted. - Dhopers.com"
    elsif self.aasm_state == Order::PROCESSED.to_s
      return "Your order(#{self.order_number}) is ready delivery - Dhopers.com"
    elsif self.aasm_state == Order::DELIVERED.to_s
      return "Your order(#{self.order_number}) has been delivered. Thank you being with us- Dhopers.com"
    else
      return false
    end
  end

  def send_order_notification
    if self.order_sms_txt
      self.sms_service.send_sms(self.phone, self.order_sms_txt)
    end

    if self.aasm_state == Order::REQUESTED.to_s
      OrderEventMailer.thank_you(self).deliver_now
    elsif self.aasm_state == Order::ACCEPTED.to_s
      OrderEventMailer.order_received(self).deliver_now
    elsif self.aasm_state == Order::PROCESSED.to_s
      OrderEventMailer.order_processed(self).deliver_now
    elsif self.aasm_state == Order::DELIVERED.to_s
      OrderEventMailer.order_delivery_notification(self).deliver_now
      create_payment_history
    end
  end

  def send_sms
    puts self.order_sms_txt
    self.sms_service.send_sms(self.phone, self.order_sms_txt)
  end

  protected

  def sms_service
    @sms = SmsService.new
  end

  private
  def trigger_order_events
    self.order_events.create!(current_state: self.aasm_state, previous_state: self.aasm_state_was || 'requested', user: self.user)
  end

  def generate_order_num
    self.order_number = get_order_number
  end

  def get_order_number
    "#{Order::ORDER_BASE_NUMBER + Order.maximum(:id).to_i.next}"
  end

  def create_payment_history
    self.payments.create!(
        {
            due:         true,
            amount:      self.amount,
            notes:       "Payment for Order##{self.order_number}",
            discount:    0,
            final_price: self.amount
        }
    )
  end

end
