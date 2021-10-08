# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sharings', type: :request do
  let(:user) { create(:user) }
  let(:shared_user) { create(:user) }
  let(:note) { create(:note, user: user) }
  let!(:sharings) { create_list(:sharing, 10, note: note, user: shared_user) }

  describe 'GET #index' do
    before(:each) do
      @headers = { Authorization: authentication_token(user) }
    end

    it 'Get sharings from note' do
      get api_v1_note_sharings_path(note), headers: @headers
      expect(response).to have_http_status(:ok)
      expect(json_response).to be_an(Hash)
      expect(json_response_data_ids).to eq(sharings.map(&:id))
    end
  end
end
