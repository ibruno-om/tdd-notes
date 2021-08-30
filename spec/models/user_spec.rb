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
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('email@addresse.foo').for(:email) }
    it { should_not allow_value('foo').for(:email) }
    it { should validate_presence_of(:password_digest) }
  end

  describe 'associations' do
    it { should have_one_attached(:avatar) }
  end
end
