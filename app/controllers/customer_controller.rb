class CustomerController < ApplicationController


  private

  def prevent_non_customer_user
    if current_user && !current_user.customer?
      flash[:error] = 'Unrecognised access'
      redirect_to root_url
    end
  end

end
