class SubscriptionErrorsDecorator
  def initialize(errors)
    self.errors = errors.to_h
  end

  def decorate
    { errors: messages }
  end

  def messages
    errors.to_h.inject({}) do |hash, (key, value)|
      hash.merge({ key.to_sym => value.map(&:validation) })
    end
  end

  private

  attr_accessor :errors
end
