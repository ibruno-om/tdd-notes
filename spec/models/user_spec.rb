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
    it { should validate_length_of(:name).is_at_least(3).on(:save) }
    it { should validate_length_of(:name).is_at_most(125).on(:save) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('email@addresse.foo').for(:email) }
    it { should_not allow_value('foo').for(:email) }
    it { should validate_length_of(:email).is_at_least(3).on(:save) }
    it { should validate_presence_of(:password_digest) }
    it { should allow_value('Foo#1234').for(:password) }
    it { should_not allow_value('fooo1234').for(:password) }
    it { should validate_length_of(:password).is_at_least(8).on(:save) }
    it { should validate_length_of(:password).is_at_most(24).on(:save) }
  end

  describe 'associations' do
    it { should have_one_attached(:avatar) }
  end
end
