# == Schema Information
#
# Table name: sharings
#
#  id         :bigint           not null, primary key
#  note_id    :bigint           not null
#  user_id    :bigint           not null
#  permission :integer          default("view")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :sharing do
    note
    user
    permission { %i[view edit].sample }
  end
end
