if Rails.env.production?
  Rails.configuration.stripe = {
    publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
    secret_key: ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    publishable_key: 'pk_test_LfGe2zrshephwx2tAUjHSq16',
    secret_key: 'sk_test_3xFWHfjK2l9BlXJHVoNpcucM'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]