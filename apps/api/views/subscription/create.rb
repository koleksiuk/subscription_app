module Api::Views::Subscription
  class Create
    include Api::View

    format :json
    layout false

    def render
      obj = { subscription: SubscriptionDecorator.new(subscription).to_h }

      raw(obj.to_json)
    end
  end
end
