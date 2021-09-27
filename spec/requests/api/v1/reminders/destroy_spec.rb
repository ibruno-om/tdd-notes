require 'rails_helper'

RSpec.describe 'Api::V1::Reminders', type: :request do
  let(:user) { create(:user) }
  let(:note_with_reminder) { create(:note_with_reminder, user: user) }

  describe 'DELETE /destroy' do
    before(:each) do
      @headers = { Authorization: authentication_token(user) }
    end

    subject { delete api_v1_note_reminders_path(note_with_reminder), headers: @headers }
    it 'Should delete reminder' do
      note_with_reminder
      expect { subject }.to change { Reminder.count }.by(-1)
      expect(response).to have_http_status(:accepted)
      expect { Reminder.find(note_with_reminder.reminder.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
