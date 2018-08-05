module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

  module AuthHelpers
    def auth_headers
      { 'Authorization': "Token token=#{ENV['HOWITZER_TOKEN']}" }
    end
  end
end
