require 'rails_helper'

RSpec.describe 'Api::V1::Reminders', type: :request do
  let(:user) { create(:user) }
  let(:note) { create(:note, user: user) }
  let(:item) { create(:item, note: note) }

  describe 'DELETE /destroy' do
    before(:each) do
      @headers = { Authorization: authentication_token(user) }
    end

    subject { delete api_v1_note_item_path(note, item), headers: @headers }
    it 'Should delete item' do
      item
      expect { subject }.to change { Item.count }.by(-1)
      expect(response).to have_http_status(:accepted)
      expect { Item.find(item.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
