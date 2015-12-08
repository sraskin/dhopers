class AdminNotificaitonMailer < ApplicationMailer

  default from: 'no-reply@dhopers.com'

  ADMINS = ['linkon@dhopers.com', 'shakil@dhopers.com', 'tonmoy@dhopers.com']

  def new_user(user)
    @user = user
    mail(to: ADMINS, subject: "Dhopers: New user just signed up!")
  end
end
