# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes Request', type: :request do
  let!(:notes) { create_list(:note, 15) }
  let(:user) { create(:user) }
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

  describe 'GET #index' do
    context 'with valid user token' do
      before(:each) do
        @headers = { Authorization: authentication_token(user) }
      end

      it 'List default pagination' do
        get api_v1_notes_path, headers: @headers

        expect(response).to have_http_status(:ok)
        expect(json_response_data).to be_an(Array)
        expect(json_response_data_ids.size).to eq(10)
      end

      it 'List paginated notes, page 2 and 5 notes' do
        get api_v1_notes_path, params: { page: 2, size: 5 }, headers: @headers

        expect(response).to have_http_status(:ok)
        expect(json_response_data).to be_a(Array)
        expect(json_response_data_ids.size).to eq(5)
      end
    end

    context 'with invalid user token' do
      subject { get api_v1_notes_path, headers: header_invalid_token }
      it_behaves_like 'fordidden_requests'
    end
  end

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

    context 'with invalid user token' do
      subject { get api_v1_note_path(notes.sample), headers: header_invalid_token }
      it_behaves_like 'fordidden_requests'
    end
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

  describe 'DELETE #destroy' do
    context 'with valid user token' do
      before(:each) do
        @headers ||= { Authorization: authentication_token(user) }
      end

      it 'Successfully delete' do
        delete api_v1_note_path(notes.sample), headers: @headers

        expect(response).to have_http_status(:accepted)
      end

      it 'Not existent ID' do
        delete api_v1_note_path(0), headers: @headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Fail to delete' do
      subject { delete api_v1_note_path(notes.sample), headers: @headers }

      it 'should return unprocessable_entity' do
        @headers = { Authorization: authentication_token(user) }
        allow_any_instance_of(Note).to receive(:destroy).and_return(false)
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid user token' do
      subject { delete api_v1_note_path(notes.sample), headers: header_invalid_token }
      it_behaves_like 'fordidden_requests'
      it { expect { subject }.to change { Note.count }.by(0) }
    end
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

    context 'Invalid update note' do
      before(:each) do
        @headers ||= { Authorization: authentication_token(user) }
      end

      subject { put api_v1_note_path(notes.sample), params: invalid_params, headers: @headers }

      it_behaves_like 'jsonapi_error_entity_requests'
    end
  end
end
