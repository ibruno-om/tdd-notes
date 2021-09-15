# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes Create request', type: :request do
  let(:user) { create(:user) }
  let(:user_without_notes) { create(:user) }
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

  describe 'POST #create' do
    context 'with valid user token' do
      before(:each) do
        @headers = { Authorization: authentication_token(user) }
      end
      context 'note without images' do
        subject { post api_v1_notes_path, params: valid_params, headers: @headers }
        it 'Create new note' do
          expect { subject }.to change { Note.count }.by(1)
          expect(response).to have_http_status(:created)
          expect(json_response_data).to be_an(Hash)
          expect(json_response_data[:id]).not_to be_nil
          expect(json_response_data[:attributes].compact).to eq(valid_params[:data][:attributes])
        end
      end

      context 'note with iamges' do
        it 'Create new note with images' do
          post api_v1_notes_path, params: params_with_images, headers: @headers

          expect(response).to have_http_status(:created)
          expect(json_response_data).to be_an(Hash)
          expect(json_response_data[:id]).not_to be_nil
          expect(json_response_data[:attributes][:images]).not_to be_nil
          expect(json_response_data[:attributes][:images].size).to eq(2)
        end
      end
    end

    context 'Invalid record' do
      subject do
        post api_v1_notes_path,
             params: invalid_params,
             headers: { Authorization: authentication_token(user) }
      end

      it_behaves_like 'jsonapi_error_entity_requests'
    end

    context 'with invalid user token' do
      subject { post api_v1_notes_path, params: valid_params, headers: header_invalid_token }
      it_behaves_like 'fordidden_requests'
    end
  end
end
