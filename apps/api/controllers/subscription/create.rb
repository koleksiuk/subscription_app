module Api::Controllers::Subscription
  class Create
    include Api::Action

    expose :subscription

    params do
      param :subscription do
        param :email, presence: true
        param :first_name, presence: true
        param :last_name
      end
    end

    def initialize(repository = SubscriptionRepository)
      @repository = repository
    end

    def call(params)
      unless params.valid?
        halt 422, Api::Views::Errors::InvalidSubscription.new(nil, errors: errors).render
      end

      new_subscription = Subscription.new(params[:subscription])

      result = Api::Interactors::Subscribe.new(@repository, new_subscription).call

      @subscription = result.subscription

      unless result.success?
        halt 422, Api::Views::Errors::InvalidSubscription.new(
          nil, errors: result.errors.inject(&:merge!)
        ).render
      end
    end
  end
end
