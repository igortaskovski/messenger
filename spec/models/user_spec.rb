require 'rails_helper'

RSpec.describe User, type: :model do
  context 'before publication' do
    let(:user) { build(:user) }

    it 'must have a name' do
      user.name = nil
      expect(user.save).to eq(false)
    end

    it 'must have email' do
      user.email = nil
      expect(user.save).to eq(false)
    end

    it 'must have password' do
      user.password = nil
      expect(user.save).to eq(false)
    end
  end
end