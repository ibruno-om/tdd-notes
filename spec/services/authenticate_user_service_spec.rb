# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticateUserService, type: :service do
  let(:user) { create(:user) }
  let(:key) { Rails.application.secrets.secret_key_base }

  describe '.authenticate' do
    context 'valid password' do
      subject { AuthenticateUserService.new(user.email, user.password).authenticate }
      it 'return valid JWT' do
        expect(subject).not_to be_nil
        expect(payload).to eq({ user_id: user.id, name: user.name })
      end
    end

    context 'invalid password' do
      subject { AuthenticateUserService.new(user.email, "#{user.password}123foo").authenticate }
      it { expect(subject).to be_nil }
    end
  end

  private

  def payload
    JWT.decode(subject, key)[0]&.deep_symbolize_keys&.select { |k, _| %i[user_id name].include?(k) }
  end
end
