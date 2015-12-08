class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_many :orders
  has_many :received_orders, class_name: 'Order', foreign_key: :order_receiver_id

  CUSTOMER = 0
  COLLECTOR = 1
  ADMIN = 2
  MANAGER = 3

  ROLES = {
      customer: CUSTOMER,
      collector: COLLECTOR,
      admin: ADMIN,
      manager: MANAGER
  }

  validates :first_name, :last_name, :presence => true

  after_create :notify_operations_team

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def customer?
    self.role == User::CUSTOMER
  end

  def admin?
    self.role == User::ADMIN
  end

  def collector?
    self.role == User::COLLECTOR
  end

  def manager?
    self.role == User::MANAGER
  end

  def notify_operations_team
    self.send_confirmation_instructions
    AdminNotificaitonMailer.new_user(self).deliver
  end

  protected
  def confirmation_required?
    false
  end

end
