require 'json'

module Api::Views::Dashboard
  class Index
    include Api::View

    format :json
    layout false

    def render
      raw(JSON.generate({foo: 'bar'}))
    end
  end
end
