# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items Request', type: :request do
  let!(:items) { create_list(:item, 10) }

  describe 'GET #index' do
    it 'Get itens from note' do
      note = items.sample.note

      get api_v1_note_items_path(note)
      expect(response).to have_http_status(:ok)
      expect(json_response).to be_an(Array)
    end
  end
end
