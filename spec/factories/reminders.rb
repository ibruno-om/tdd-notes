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
FactoryBot.define do
  factory :reminder do
    note
    notification_time { Time.zone.now }
  end
end
