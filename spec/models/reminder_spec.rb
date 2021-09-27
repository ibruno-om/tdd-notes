# == Schema Information
#
# Table name: reminders
#
#  id                :bigint           not null, primary key
#  note_id           :bigint           not null
#  notification_time :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
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

  context 'callbacks' do
    it 'schedule reminder' do
      expect { create(:reminder, notification_time: Date.tomorrow.noon) }.to have_enqueued_job.on_queue(:reminders).at(Date.tomorrow.noon)
    end
  end
end
