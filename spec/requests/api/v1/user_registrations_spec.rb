require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  let(:valid_params) do
    { data: { attributes: attributes_for(:user) } }
  end

  let(:invalid_params) do
    { data: { attributes: attributes_for(:user, email: nil) } }
  end

  describe 'POST /create' do
    context 'valid params' do
      subject { post api_v1_user_registrations_path, params: valid_params }

      it 'should return create a new user and return proper response' do
        expect { subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(:created)
        expect(json_response_data).to be_an(Hash)
        expect(json_response_data[:id]).not_to be_nil
        expect(json_response_data[:attributes].compact.except(:'created-at')).to eq(valid_params[:data][:attributes].except(:password))
      end
    end

    context 'invalid params' do
      subject { post api_v1_user_registrations_path, params: invalid_params }

      it_behaves_like 'jsonapi_error_entity_requests'
    end
  end
end
