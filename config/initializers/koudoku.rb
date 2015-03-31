Koudoku.setup do |config|
  config.subscriptions_owned_by = :user
  config.stripe_publishable_key = "pk_test_bQKadVSr1pM6WE8dmyAz9XZ6"
  config.stripe_secret_key = "sk_test_8Bjdwp72NXQ87SMd8q0bc82M"
  # config.prorate = false # Default is true, set to false to disable prorating subscriptions
  # config.free_trial_length = 30
  
  # you can subscribe to additional webhooks here
  # we use stripe_event under the hood and you can subscribe using the 
  # stripe_event syntax on the config object: 
  # config.subscribe 'charge.failed', Koudoku::ChargeFailed
  config.subscriptions_owned_by = :user
end
