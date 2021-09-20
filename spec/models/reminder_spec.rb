# frozen_string_literal

require 'rails_helper'

RSpec.describe Reminder, type: :model do
  context 'validations' do
    it { should validate_presence_of(:note) }
    it { should validate_presence_of(:notification_time) }
  end

  context 'associations' do
    it { should belong_to(:note).required }
  end
end
