require 'rails_helper'

shared_examples_for 'record_not_found_requests' do
  let(:not_found_error) do
    { status: '404', error: 'Record not found' }
  end

  it 'should return 404 status code' do
    subject
    expect(response).to have_http_status(404)
  end

  it 'should return proper error body' do
    subject
    expect(json_response.deep_symbolize_keys).to include(not_found_error)
  end
end
