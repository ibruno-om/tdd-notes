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
require 'rails_helper'

RSpec.describe Sharing, type: :model do
  describe 'associations' do
    it { should belong_to(:note).required }
    it { should belong_to(:user).required }
  end

  describe 'validations' do
    it { should validate_presence_of(:note) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:permission) }
  end
end
