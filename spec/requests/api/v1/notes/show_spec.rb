# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes Show request', type: :request do
  let(:user) { create(:user) }
  let(:user_without_notes) { create(:user) }
  let!(:notes) { create_list(:note, 15, { user: user }) }
  let(:header_invalid_token) { { Authorization: 'Bearer foo123456789' } }

  describe 'GET #show' do
    context 'with valid user token' do
      before(:each) do
        @headers = { Authorization: authentication_token(user) }
      end
      it 'Existent ID' do
        note = notes.sample
        get api_v1_note_path(note), headers: @headers

        expect(response).to have_http_status(:ok)
        expect(json_response_data).to be_an(Hash)
        expect(json_response_data).to eq(serialize_model_as_json(note)[:data])
      end

      it 'Not existent ID' do
        get api_v1_note_path(0), headers: @headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'User without notes' do
      before(:each) do
        @headers = { Authorization: authentication_token(user_without_notes) }
      end

      it 'should return "not found" for a user without notes.' do
        get api_v1_note_path(notes.sample), headers: @headers

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with invalid user token' do
      subject { get api_v1_note_path(notes.sample), headers: header_invalid_token }
      it_behaves_like 'fordidden_requests'
    end
  end
end
