class DailyMailer
  @@from    = 'daily-email@example.com'
  @@subject = 'Your daily email!'

  def initialize(receipents)
    self.receipents = Array(receipents)
  end

  def deliver
    mail.deliver
  end

  private

  attr_accessor :receipents

  def mail
    mails = receipents

    Mail.new do
      from    @@from
      to      mails
      subject @@subject
      body    Quote.new.fetch
    end
  end
end
