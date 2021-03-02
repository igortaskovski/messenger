require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'before publication' do
    let(:comment) { build(:comment) }

    it 'must have a body' do
      comment.body = nil
      expect(comment.save).to eq(false)
    end
  end

  describe "under a post" do
    let(:comment) { build(:comment) }
    it "belongs to a post " do
      expect(comment.post).to be_truthy
    end
   end

  describe "does not have minimum 5 chars" do
    let(:comment) { build(:comment, body:'12') }
    it 'should be invalid' do
      expect(comment.valid?).to be_falsey
    end
  end
end
