require 'rails_helper'

RSpec.describe 'Api::V1::Sharings', type: :request do
  let(:user) { create(:user) }
  let(:note) { create(:note, user: user) }
  let(:sharing) { create(:sharing, note: note) }

  describe 'DELETE /destroy' do
    before(:each) do
      @headers = { Authorization: authentication_token(user) }
    end

    subject { delete api_v1_note_sharing_path(note, sharing), headers: @headers }
    it 'Should delete sharing' do
      sharing
      expect { subject }.to change { Sharing.count }.by(-1)
      expect(response).to have_http_status(:accepted)
      expect { Sharing.find(sharing.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
