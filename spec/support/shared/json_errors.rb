require 'rails_helper'

shared_examples_for 'record_not_found_requests' do
  let(:not_found_error) { NOT_FOUND_RESPONSE }

  it 'should return 404 status code' do
    subject
    expect(response).to have_http_status(:not_found)
  end

  it 'should return proper error body for not found' do
    subject
    expect(json_response.deep_symbolize_keys).to include(not_found_error)
  end
end

shared_examples_for 'jsonapi_error_entity_requests' do
  it 'should return 422 status code' do
    subject
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'should return proper error body' do
    subject
    expect(json_response).to be_an(Hash)
    expect(json_response).to have_key('errors')
    expect(json_response.deep_symbolize_keys[:errors].map(&:keys).uniq.flatten).to eq(%i[source detail])
  end
end

shared_examples_for 'fordidden_requests' do
  let(:forbidden_error) { { errors: [AUTHORIZATION_ERROR_RESPONSE] } }

  it 'should return 403 status code' do
    subject
    expect(response).to have_http_status(:forbidden)
  end

  it 'should return proper error body for fordidden' do
    subject
    expect(json_response.deep_symbolize_keys).to eq(forbidden_error)
  end
end
