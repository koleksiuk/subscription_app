class Subscription
  include Lotus::Entity
  include Lotus::Validations

  attributes :id, :email, :first_name, :last_name, :created_at, :confirmed_at

  def full_name
    [first_name, last_name].reject {|s| s.nil? || s.empty? }.join(' ')
  end
end
