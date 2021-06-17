require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:note) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
  end
end
