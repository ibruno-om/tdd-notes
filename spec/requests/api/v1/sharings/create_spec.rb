# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sharings', type: :request do
  let(:user) { create(:user) }
  let(:shared_user) { create(:user) }
  let(:note) { create(:note, user: user) }
  let(:valid_params) do
    { data: { attributes: attributes_for(:sharing, user_id: shared_user.id) } }
  end

  describe 'POST #create' do
    before(:each) do
      @headers = { Authorization: authentication_token(user) }
    end

    subject { post api_v1_note_sharings_path(note), params: valid_params, headers: @headers }
    it 'Should create new sharing' do
      expect { subject }.to change { Sharing.count }.by(1)
      expect(response).to have_http_status(:ok)
      expect(json_response_data).to be_an(Hash)
      expect(json_response_data).to eq(serialize_model_as_json(note.sharings.first)[:data])
    end
  end
end
