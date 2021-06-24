# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes Request', type: :request do
  let!(:notes) { create_list(:note, 15) }
  let(:new_note) { attributes_for(:note) }
  let(:udpate_note) { attributes_for(:note) }
  let(:invalid_udpate_note) { attributes_for(:note, { title: nil }) }
  let(:invalid_new_note) { attributes_for(:note, { title: nil }) }

  describe 'GET #index' do
    it 'List default pagination' do
      get api_v1_notes_path

      expect(response).to have_http_status(200)
      expect(json_response).to be_an(Array)
      expect(json_response.size).to eq(10)
    end

    it 'List paginated notes, page 2 and 5 notes' do
      get api_v1_notes_path, params: { page: 2, size: 5 }

      expect(response).to have_http_status(200)
      expect(json_response).to be_a(Array)
      expect(json_response.size).to eq(5)
    end
  end

  describe 'GET #show' do
    it 'Existent ID' do
      note = notes.sample
      get api_v1_note_path(note)

      expect(response).to have_http_status(200)
      expect(json_response).to be_an(Hash)
      expect(json_response).to eq(note.as_json)
    end

    it 'Not existent ID' do
      get api_v1_note_path(0)
      expect(response).to have_http_status(404)
    end
  end

  describe 'POST #create' do
    it 'Create new note' do
      post api_v1_notes_path, params: { note: new_note }

      expect(response).to have_http_status(200)
      expect(json_response).to be_an(Hash)
      expect(json_response).to have_key('id')
      expect(json_response.symbolize_keys
        .select { |key, _| new_note.keys.include?(key) })
        .to eq(new_note)
    end

    it 'Invalid record' do
      post api_v1_notes_path, params: { note: invalid_new_note }

      expect(response).to have_http_status(406)
      expect(json_response).to be_an(Hash)
      expect(json_response).to have_key('errors')
    end
  end

  describe 'DELETE #destroy' do
    it 'Successfully delete' do
      delete api_v1_note_path(notes.sample)

      expect(response).to have_http_status(202)
    end

    it 'Not existent ID' do
      delete api_v1_note_path(0)
      expect(response).to have_http_status(404)
    end
  end

  describe 'PUT/PATCH #update' do
    it 'Successfully update record' do
      note = notes.sample

      put api_v1_note_path(note), params: { note: udpate_note }

      expect(response).to have_http_status(200)
      expect(json_response).to be_an(Hash)
      expect(json_response.symbolize_keys
        .select { |key, _| udpate_note.keys.include?(key) })
        .to eq(udpate_note)
    end

    it 'Invalid update note' do
      note = notes.sample

      put api_v1_note_path(note), params: { note: invalid_udpate_note }

      expect(response).to have_http_status(422)
      expect(json_response).to be_an(Hash)
      expect(json_response).to have_key('errors')
    end
  end
end
