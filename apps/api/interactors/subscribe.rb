require 'lotus/interactor'

module Api::Interactors
  class Subscribe
    include Lotus::Interactor

    expose :subscription

    def initialize(repository, subscription)
      @repository   = repository
      @subscription = subscription
    end

    def call
      insert_subscription
    end

    private

    def insert_subscription
      @subscription = @repository.create(@subscription)
    rescue Sequel::UniqueConstraintViolation
      error({
        email: [Lotus::Validations::Error.new(:email, :uniqueness, :unique, :not_unique)]
      })
    end
  end
end
