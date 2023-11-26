module Requests
  module JsonHelpers
    def response_json
      JSON.parse(response.body)
    end
  end

  module AuthHelpers
    def auth_headers
      { Authorization: "Token token=#{ENV.fetch('HOWITZER_TOKEN', nil)}" }
    end
  end
end
