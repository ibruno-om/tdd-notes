# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items Request', type: :request do
  let(:user) { create(:user) }
  let(:note) { create(:note, user: user) }
  let(:item) { create(:item, note: note) }
  let(:valid_params) do
    { data: { attributes: attributes_for(:item) } }
  end

  describe 'PUT/PATCH #update' do
    before(:each) do
      @headers = { Authorization: authentication_token(user) }
    end

    subject { put api_v1_note_item_path(note, item), params: valid_params, headers: @headers }
    it 'Should update item' do
      item
      expect { subject }.to change { Item.count }.by(0)
      expect(response).to have_http_status(:ok)
      expect(json_response_data).to be_an(Hash)
      expect(json_response_data[:attributes]).to eq(valid_params[:data][:attributes])
    end
  end
end
