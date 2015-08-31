collection :subscriptions do
  entity Subscription
  repository SubscriptionRepository

  attribute :id, Integer
  attribute :email,        String
  attribute :first_name,   String
  attribute :last_name,    String
  attribute :created_at,   DateTime
end
