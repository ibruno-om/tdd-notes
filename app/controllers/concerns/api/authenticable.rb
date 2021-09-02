# frozen_literal_string: true
module Api
  module Authenticable
    class AuthorizationError < StandardError; end
    extend ActiveSupport::Concern

    included do
      rescue_from Api::Authenticable::AuthorizationError, with: :authorization_error

      private

      def authenticate!
        raise Api::Authenticable::AuthorizationError, 'Invalid Authentication Token' if current_user.nil?
      end

      def current_user
        @current_user ||= User.find(decoded_auth_token&.fetch(:user_id, nil))
      rescue ActiveRecord::RecordNotFound
        nil
      end

      def decoded_auth_token
        @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
      end

      def http_auth_header
        return {} unless request.headers['Authorization'].present?

        request.headers['Authorization'].split.last
      end

      # Handle authorization resource error
      def authorization_error
        render json: { errors: [AUTHORIZATION_ERROR_RESPONSE] }, status: :forbidden
      end
    end
  end
end
