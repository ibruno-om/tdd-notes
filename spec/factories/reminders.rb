FactoryBot.define do
  factory :reminder do
    note
    notification_time { Time.zone.now }
  end
end
