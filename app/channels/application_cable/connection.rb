module ApplicationCable
  class Connection < ActionCable::Connection::Base
    class AuthorizationError < StandardError; end
    identified_by :current_user

    def connect
      raise ApplicationCable::Connection::AuthorizationError unless request.headers['Authorization'].present?

      self.current_user = find_verified_user
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError, ApplicationCable::Connection::AuthorizationError
      reject_unauthorized_connection
    end

    private

    def find_verified_user
      @jwt_token = JsonWebToken.decode(authorization_token)
      User.find(@jwt_token&.fetch(:user_id, nil))
    end

    def authorization_token
      request.headers['Authorization'].split.last
    end
  end
end
