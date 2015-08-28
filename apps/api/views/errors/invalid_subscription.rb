require 'json'

module Api::Views::Errors
  class InvalidSubscription
    include Api::View

    format :json
    layout false

    # Expects following locals:
    # * errors

    def render
      json = JSON.generate(SubscriptionErrorsDecorator.new(errors).decorate)

      raw(json)
    end
  end
end

