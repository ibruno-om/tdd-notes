# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items Request', type: :request do
  let(:user) { create(:user) }
  let(:note) { create(:note, user: user) }
  let(:valid_params) do
    { data: { attributes: attributes_for(:item) } }
  end

  describe 'POST #create' do
    before(:each) do
      @headers = { Authorization: authentication_token(user) }
    end

    subject { post api_v1_note_items_path(note), params: valid_params, headers: @headers }
    it 'Should create new item' do
      expect { subject }.to change { Item.count }.by(1)
      expect(response).to have_http_status(:ok)
      expect(json_response_data).to be_an(Hash)
      expect(json_response_data).to eq(serialize_model_as_json(note.items.first)[:data])
    end
  end
end
