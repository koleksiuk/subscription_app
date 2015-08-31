require 'rake'
require 'rubygems'
require 'bundler/setup'
require 'lotus/setup'
require_relative './lib/subscription_site'

desc "Send emails"
task :send_emails do
  emails = SubscriptionRepository.find_emails.to_a.map(&:email)

  DailyMailer.new(emails).deliver
end
