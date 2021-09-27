# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items Request', type: :request do
  let(:user) { create(:user) }
  let(:note) { create(:note, user: user) }
  let!(:items) { create_list(:item, 10, note: note) }

  describe 'GET #index' do
    before(:each) do
      @headers = { Authorization: authentication_token(user) }
    end

    it 'Get itens from note' do
      get api_v1_note_items_path(note), headers: @headers
      expect(response).to have_http_status(:ok)
      expect(json_response).to be_an(Hash)
      expect(json_response_data_ids).to eq(items.map(&:id))
    end
  end
end
