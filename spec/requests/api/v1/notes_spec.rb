# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes Request', type: :request do
  let!(:notes) { create_list(:note, 15) }
  let(:new_note) { attributes_for(:note) }
  let(:udpate_note) { attributes_for(:note) }
  let(:invalid_udpate_note) { attributes_for(:note, { title: nil }) }
  let(:invalid_new_note) { attributes_for(:note, { title: nil, content: nil }) }

  describe 'GET #index' do
    it 'List default pagination' do
      get api_v1_notes_path

      expect(response).to have_http_status(:ok)
      expect(json_response_data).to be_an(Array)
      expect(json_response_data_ids.size).to eq(10)
    end

    it 'List paginated notes, page 2 and 5 notes' do
      get api_v1_notes_path, params: { page: 2, size: 5 }

      expect(response).to have_http_status(:ok)
      expect(json_response_data).to be_a(Array)
      expect(json_response_data_ids.size).to eq(5)
    end
  end

  describe 'GET #show' do
    it 'Existent ID' do
      note = notes.sample
      get api_v1_note_path(note)

      expect(response).to have_http_status(:ok)
      expect(json_response_data).to be_an(Hash)
      expect(json_response_data).to eq(serialize_model_as_json(note)[:data])
    end

    it 'Not existent ID' do
      get api_v1_note_path(0)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    it 'Create new note' do
      post api_v1_notes_path, params: { note: new_note }

      expect(response).to have_http_status(:ok)
      expect(json_response_data).to be_an(Hash)
      expect(json_response_data).to have_key(:id)
      expect(json_response_data[:attributes]
        .select { |key, _| new_note.keys.include?(key) })
        .to eq(new_note)
    end

    context 'Invalid record' do
      subject { post api_v1_notes_path, params: { note: invalid_new_note } }

      it_behaves_like 'jsonapi_error_entity_requests'
    end
  end

  describe 'DELETE #destroy' do
    it 'Successfully delete' do
      delete api_v1_note_path(notes.sample)

      expect(response).to have_http_status(:accepted)
    end

    it 'Not existent ID' do
      delete api_v1_note_path(0)
      expect(response).to have_http_status(:not_found)
    end

    context 'Fail to delete' do
      subject { delete api_v1_note_path(notes.sample) }

      it 'should return unprocessable_entity' do
        allow_any_instance_of(Note).to receive(:destroy).and_return(false)
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT/PATCH #update' do
    context 'Successfully update record' do
      subject { put api_v1_note_path(notes.sample), params: { note: udpate_note } }

      it 'Return properly body response' do
        subject
        expect(response).to have_http_status(:ok)
        expect(json_response_data).to be_an(Hash)
        expect(json_response_data[:attributes]
          .select { |key, _| udpate_note.keys.include?(key) })
          .to eq(udpate_note)
      end
    end

    context 'Invalid update note' do
      subject { put api_v1_note_path(notes.sample), params: { note: invalid_udpate_note } }

      it_behaves_like 'jsonapi_error_entity_requests'
    end
  end
end
