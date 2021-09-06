# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password
  validates :name, :email, :password_digest, presence: true
  validates :name, length: { minimum: 3, maximum: 125 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, length: { minimum: 3 }
  validates :email, uniqueness: true
  validates :password, format: { with: Constants::PASSWORD_REQUIREMENTS,
                                 message: 'Must include at least one lowercase letter, one uppercase letter, and one digit' },
                       length: { minimum: 8, maximum: 24 }
  has_one_attached :avatar
end
