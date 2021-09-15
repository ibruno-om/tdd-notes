# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes Create request', type: :request do
  let(:user) { create(:user) }
  let(:user_without_notes) { create(:user) }
  let!(:notes) { create_list(:note, 15, { user: user }) }
  let(:header_invalid_token) { { Authorization: 'Bearer foo123456789' } }
  let(:valid_params) do
    { data: { attributes: attributes_for(:note) } }
  end
  let(:invalid_params) do
    { data: { attributes: attributes_for(:note, { title: nil, content: nil }) } }
  end
  let(:params_with_images) do
    { data: { attributes: attributes_for(:note_with_images) } }
  end

  describe 'PUT/PATCH #update' do
    context 'with valid user token' do
      before(:each) do
        @headers ||= { Authorization: authentication_token(user) }
      end

      subject { put api_v1_note_path(notes.sample), params: valid_params, headers: @headers }

      it 'update and return properly body response' do
        subject
        expect(response).to have_http_status(:ok)
        expect(json_response_data).to be_an(Hash)
        expect(json_response_data[:attributes].compact).to eq(valid_params[:data][:attributes])
      end

      it { expect { subject }.to change { Note.count }.by(0) }
    end

    context 'tries to update another user notes' do
      before(:each) do
        @headers ||= { Authorization: authentication_token(user_without_notes) }
      end

      it 'should returns not found' do
        put api_v1_note_path(notes.sample), params: valid_params, headers: @headers

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Invalid update note' do
      before(:each) do
        @headers ||= { Authorization: authentication_token(user) }
      end

      subject { put api_v1_note_path(notes.sample), params: invalid_params, headers: @headers }

      it_behaves_like 'jsonapi_error_entity_requests'
    end
  end
end
