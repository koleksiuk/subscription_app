require 'json'

class SubscriptionDecorator
  def initialize(subscription)
    self.subscription = subscription
  end

  def to_h
    {
      id:    subscription.id,
      email: subscription.email,
      name:  subscription.full_name
    }
  end

  private

  attr_accessor :subscription
end
