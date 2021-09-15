# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes Show request', type: :request do
  let(:user) { create(:user) }
  let(:user_without_notes) { create(:user) }
  let!(:notes) { create_list(:note, 15, { user: user }) }
  let(:header_invalid_token) { { Authorization: 'Bearer foo123456789' } }

  describe 'DELETE #destroy' do
    context 'with valid user token' do
      before(:each) do
        @headers ||= { Authorization: authentication_token(user) }
      end

      it 'Successfully delete' do
        delete api_v1_note_path(notes.sample), headers: @headers

        expect(response).to have_http_status(:accepted)
      end

      it 'Not existent ID' do
        delete api_v1_note_path(0), headers: @headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'tries to delete another user notes' do
      before(:each) do
        @headers ||= { Authorization: authentication_token(user_without_notes) }
      end

      it 'should returns not found' do
        delete api_v1_note_path(notes.sample), headers: @headers

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'Fail to delete' do
      subject { delete api_v1_note_path(notes.sample), headers: @headers }

      it 'should return unprocessable_entity' do
        @headers = { Authorization: authentication_token(user) }
        allow_any_instance_of(Note).to receive(:destroy).and_return(false)
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with invalid user token' do
      subject { delete api_v1_note_path(notes.sample), headers: header_invalid_token }
      it_behaves_like 'fordidden_requests'
      it { expect { subject }.to change { Note.count }.by(0) }
    end
  end
end
