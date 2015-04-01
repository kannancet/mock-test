class SubscriptionsController < ApplicationController

	before_filter :set_plan, only: [:new, :create]

	#Function to create subscription
	def plans
	  @plans = Plan.all
	end

	#Function for new subscription form
	def new	
	  @currencies = CURRENCIES	
	end

	#Function to 
	def create
		begin

		  customer = Stripe::Customer.create(
		    :email => 'example@stripe.com',
		    :card  => params[:stripeToken]
		  )

		  charge = Stripe::Charge.create(
		    :customer    => customer.id,
		    :amount      => @amount,
		    :description => 'Rails Stripe customer',
		    :currency    => 'usd'
		  )

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to new_subscription_path(@plan)
		end
	end

	private

	#Fucntion to set the plan from Id.
	def set_plan
		@plan = Plan.find(params[:id])
	end

end
