require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'before publication' do
    let(:post) { build(:post) }

    it 'must have a title' do
      post.title = nil
      expect(post.save).to eq(false)
    end

    it 'must have a body' do
      post.body = nil
      expect(post.save).to eq(false)
    end

    it 'cannot have comments' do
      expect { Post.create.comments.create! }.to raise_error(ActiveRecord::RecordNotSaved)
    end
  end

  context "can be created with proper arguments" do
    subject { Post.create title: 'New Post', body: 'Google News is a news aggregator service developed by Google.' }

    it "returns the entire body" do
      expect(subject.body).to eq('Google News is a news aggregator service developed by Google.')
    end
  end
end
