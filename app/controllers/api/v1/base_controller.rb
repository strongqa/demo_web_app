require 'application_responder'

module API
  module V1
    class BaseController < ::ActionController::Base
      protect_from_forgery unless: -> { request.format.json? }

      self.responder = ApplicationResponder

      before_action :restrict_access

      private

      def default_serializer_options
        {
          root: false
        }
      end

      def restrict_access
        authenticate_or_request_with_http_token do |token, _options|
          token == ENV['HOWITZER_TOKEN']
        end
      end
    end
  end
end
