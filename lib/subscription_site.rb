require 'lotus/model'
require 'mail'

Dir["#{ __dir__ }/subscription_site/**/*.rb"].each { |file| require_relative file }

Lotus::Model.configure do
  ##
  # Database adapter
  #
  # Available options:
  #
  #  * Memory adapter
  #    adapter type: :memory, uri: 'memory://localhost/subscription_site_development'
  #
  #  * SQL adapter
  #    adapter type: :sql, uri: 'sqlite://db/subscription_site_development.sqlite3'
  #    adapter type: :sql, uri: 'postgres://localhost/subscription_site_development'
  #    adapter type: :sql, uri: 'mysql://localhost/subscription_site_development'
  #
  adapter type: :sql, uri: ENV['SUBSCRIPTION_SITE_DATABASE_URL']

  ##
  # Migrations
  #
  migrations 'db/migrations'
  schema     'db/schema.sql'

  ##
  # Database mapping
  #
  # Intended for specifying application wide mappings.
  #
  # You can specify mapping file to load with:
  #
  mapping "#{__dir__}/config/mapping"
  #
  # Alternatively, you can use a block syntax like the following:
  #
end.load!

Mail.defaults do
  delivery_method :test
end
