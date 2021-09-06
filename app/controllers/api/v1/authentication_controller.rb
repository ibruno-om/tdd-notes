# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      def authenticate
        token = AuthenticateUserService.new(standard_authenticate_params).authenticate

        if token.present?
          render json: token_json_response(token), status: :ok
        else
          render json: error_authenticate_response, status: :forbidden
        end
      end

      private

      def token_json_response(token)
        { data: { type: 'access_token', attributes: { token: token } } }
      end

      def standard_authenticate_params
        params.dig(:data, :attributes)&.permit(:email, :password).to_h.deep_symbolize_keys
      end

      def error_authenticate_response
        {
          errors: [
            {
              source: {
                pointer: '/data/authenticate'
              },
              detail: 'invalid e-mail or password'
            }
          ]
        }
      end
    end
  end
end
