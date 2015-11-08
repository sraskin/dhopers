class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
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

end
