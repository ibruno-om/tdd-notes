require 'rails_helper'

RSpec.describe ReminderNotificationChannel, type: :channel do
  let(:user) { create(:user) }

  context 'Connection confirmed' do
    before do
      stub_connection current_user: user
    end

    it 'subscribes to a stream when user is provided' do
      subscribe
      expect(subscription).to be_confirmed
      expect(connection.current_user).to be(user)
    end
  end
end
