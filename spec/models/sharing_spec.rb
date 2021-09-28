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
