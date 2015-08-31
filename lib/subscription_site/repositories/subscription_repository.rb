class SubscriptionRepository
  include Lotus::Repository

  def self.find_by_email(email)
    query do
      where(email: email)
    end.first
  end

  def self.find_emails
    query do
      select(:email)
    end
  end
end
