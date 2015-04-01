class Subscription < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :coupon
  belongs_to :plan

  #Function to check if subscription is active or inactive
  def active?
  	deactivation_status.blank? 
  end

  #Function to reactivate subscription
  def reactivate(flash)
  	recatch_time = ((Time.now - self.deactivated_at) / 3600).round
  	
  	if recatch_time <= 24 
  	  flash[:notice] = "Successfully activated your subscription"
      self.update(deactivation_status: false, deactivated_at: false)
    else
      self.destroy
      flash[:alert] = "Sorry! You cannot reactivate your account after 24 hours."
    end
  end

  #function to deactivate subscription
  def deactivate(flash)
  	flash[:notice] = "Successfully deactivated your subscription"
	update(deactivation_status: true, deactivated_at: Time.now)
  end

  #Function delete subscription for ever
  def remove
    customer = Stripe::Customer.retrieve(self.stripe_customer_id)
	customer.delete()
	self.destroy
  end

end
