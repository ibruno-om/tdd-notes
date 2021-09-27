# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes Index request', type: :request do
  let(:user) { create(:user) }
  let(:user_without_notes) { create(:user) }
  let!(:notes) { create_list(:note, 15, { user: user }) }
  let(:header_invalid_token) { { Authorization: 'Bearer foo123456789' } }

  describe 'GET #index' do
    context 'with valid user token' do
      before(:each) do
        @headers = { Authorization: authentication_token(user) }
      end

      it 'List default pagination' do
        get api_v1_notes_path, headers: @headers

        expect(response).to have_http_status(:ok)
        expect(json_response_data).to be_an(Array)
        expect(json_response_data_ids).to eq(notes.first(10).map(&:id))
      end

      it 'List paginated notes; show page 2 with 5 notes.' do
        get api_v1_notes_path, params: { page: 2, size: 5 }, headers: @headers

        expect(response).to have_http_status(:ok)
        expect(json_response_data).to be_a(Array)
        expect(json_response_data_ids).to eq(notes.last(5).map(&:id))
      end
    end

    context 'with invalid user token' do
      subject { get api_v1_notes_path, headers: header_invalid_token }
      it_behaves_like 'fordidden_requests'
    end

    context 'with query search' do
      let!(:note_query) { create(:note, :reindex, title: 'FooTitle', content: 'FooContent Ipsum Contetn', user: user) }
      before(:each) do
        @headers = { Authorization: authentication_token(user) }
      end

      it 'Returns the note that the title matches' do
        get api_v1_notes_path, params: { query: 'Footitle' }, headers: @headers

        expect(response).to have_http_status(:ok)
        expect(json_response_data_ids).to contain_exactly(note_query.id)
      end

      it 'Returns the note that the content matches' do
        get api_v1_notes_path, params: { query: 'Foocontent' }, headers: @headers

        expect(response).to have_http_status(:ok)
        expect(json_response_data_ids).to contain_exactly(note_query.id)
      end
    end
  end
end
