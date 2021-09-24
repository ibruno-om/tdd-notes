# frozen_string_literal: true

# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  title      :string
#  content    :text
#  color      :string
#  archived   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'associations' do
    it { should have_many(:items) }
    it { should belong_to(:user).required }
    it { should have_one(:reminder).inverse_of(:note) }
    it { should have_and_belong_to_many(:labels) }
    it { should have_many_attached(:images) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
end
