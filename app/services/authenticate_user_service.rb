# frozen_string_literal: true

class AuthenticateUserService
  def initialize(email, password)
    @email = email
    @password = password
  end

  def authenticate
    user = User.find_by_email(email)
    return unless user&.authenticate(password)

    JsonWebToken.encode(user_id: user.id, name: user.name)
  end

  private

  attr_accessor :email, :password
end
