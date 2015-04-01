class Api::SubscriptionsController < Api::BaseController
  protect_from_forgery with: :null_session



  #Function for currency conversion
  def convert_currency
  	to = currency_params[:target_currency].upcase
  	@plan = Plan.find(currency_params[:target_plan])
  	@amount = $openexchange.convert(@plan.price, :from => "USD", :to => to)
  end

  #Function to create subscriptions
  def create
  	begin

	  customer = Stripe::Customer.create(
	    :email => stripe_params[:email],
	    :card  => stripe_params[:token],
	    :plan => stripe_params[:stripe_plan]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => stripe_params[:amount],
	    :description => stripe_params[:desc],
	    :currency    => stripe_params[:currency]
	  )

	  if customer && charge
	  	new_subscription = Subscription.create(stripe_card_id: stripe_params[:card],
						                        stripe_customer_id: customer.id,
						                        stripe_charge_id: charge.id,
						                        stripe_payment_email: stripe_params[:email],
						  		                user_id: current_user.id,
						  		                plan_id: stripe_params[:target_plan].to_i)
	  @flash = {result: "success", msg: "You have successfully subscribed."}
	  end
	
	rescue Stripe::CardError => e
	  @flash = {result: "fail", msg: e.message}
	end	
  end

  private

  def subscription_params
    #params_filtered = params.require(:user).permit(:name, :gender, :country, :birth_date)
  end

  def query_params
    #params.permit(:name, :gender, :country, :birth_date)
  end	

  def currency_params
  	params.require(:currency_params).permit(:target_currency, :target_plan)
  end

  def stripe_params
  	params.require(:stripe_params).permit(:token, :amount, :email, :desc, :target_plan, :currency, :stripe_plan, :card)
  end
end
