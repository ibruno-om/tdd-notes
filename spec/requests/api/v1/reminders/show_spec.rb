require 'rails_helper'

RSpec.describe 'Api::V1::Reminders', type: :request do
  let(:user) { create(:user) }
  let(:note_with_reminder) { create(:note_with_reminder, user: user) }

  describe 'GET /show' do
    before(:each) do
      @headers = { Authorization: authentication_token(user) }
    end

    it 'Should show reminder' do
      get api_v1_note_reminders_path(note_with_reminder), headers: @headers
      expect(response).to have_http_status(:ok)
      expect(json_response_data).to be_an(Hash)
      expect(json_response_data).to eq(serialize_model_as_json(note_with_reminder.reminder)[:data])
    end
  end
end
