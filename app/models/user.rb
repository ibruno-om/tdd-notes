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
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  has_secure_password
  validates :name, :email, :password_digest, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: true

  has_one_attached :avatar
end
