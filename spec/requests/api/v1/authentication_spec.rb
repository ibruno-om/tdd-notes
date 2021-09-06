require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  describe 'POST #authenticate' do
    let(:user) { create(:user) }
    let(:key) { Rails.application.secrets.secret_key_base }
    let(:auth_error_response) do
      {
        errors: [
          {
            source: {
              pointer: '/data/authenticate'
            },
            detail: 'invalid e-mail or password'
          }
        ]
      }
    end

    context 'authenticate with valid credentials' do
      subject { post api_v1_authenticate_path, params: { data: { attributes: { email: user.email, password: user.password } } } }

      it 'should return a proper authenticate token' do
        subject
        expect(response).to have_http_status(:ok)
        expect(payload).to eq({ user_id: user.id, name: user.name })
      end
    end

    context 'authenticate with invalid credentials' do
      subject { post api_v1_authenticate_path, params: { data: { attributes: { email: user.email, password: 'foo123' } } } }

      it 'should return a proper response for no authentication' do
        subject
        expect(response).to have_http_status(:forbidden)
        expect(json_response.deep_symbolize_keys).to eq(auth_error_response)
      end
    end
  end

  private

  def payload
    JWT.decode(attribute_token, key)[0]&.deep_symbolize_keys&.select { |k, _| %i[user_id name].include?(k) }
  end

  def attribute_token
    json_response_data.fetch(:attributes, {}).fetch(:token, nil)
  end
end
