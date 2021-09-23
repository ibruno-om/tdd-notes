# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  let(:user) { create(:user) }
  # empty body
  it 'successfully connects' do
    connect '/cable', headers: { Authorization: authentication_token(user) }
    expect(connection.current_user).to eq user
  end

  it 'unsuccessfully connects' do
    expect { connect '/cable', headers: { Authorization: 'Bearer foo123456789' } }.to have_rejected_connection
  end
end
