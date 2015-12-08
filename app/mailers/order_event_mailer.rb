class OrderEventMailer < ApplicationMailer

  ADMINS = ['irfan@dhopers.com', 'irfandhk@gmail.com', 'linkon@dhopers.com', 'shakil@dhopers.com', 'tonmoy@dhopers.com']

  default from: 'no-reply@dhopers.com'

  def thank_you(order)
    @order = order
    @user  = @order.user
    @url   = @order.order_path

    mail(to: @user.email, bcc: ADMINS, subject: "Dhopers: Your order (##{@order.order_number}) created!")
  end

  def order_received(order)
    @order = order
    @user  = @order.user
    @url   = @order.order_path

    mail(to: @user.email, bcc: ADMINS, subject: "Dhopers: Your order (##{@order.order_number}) Order Received")
  end

  def order_processed(order)
    @order = order
    @user  = @order.user
    @url   = @order.order_path

    mail(to: @user.email, bcc: ADMINS, subject: "Dhopers: Your order (##{@order.order_number}) has been processed successfully")
  end

  def order_delivery_notification(order)
    @order = order
    @user  = @order.user
    @url   = @order.order_path

    mail(to: @user.email, bcc: ADMINS, subject: "Dhopers: [Your order (##{@order.order_number}) has been delivered")
  end

end
