require 'rails_helper'

RSpec.feature "Post", type: :feature do
  let!(:post) { create :post, title: 'Special Post' }

  describe 'new comment' do
    context 'user is not logged in' do
      scenario 'redirects to login path' do
        visit post_path(post)
        fill_in 'comment_body', with: 'This is my comment'
        click_on 'Publish'
        expect(page).not_to have_content('This is my comment')
        expect(page).to have_content('Login Register')
      end
    end
    
    context 'user is logged in' do
      before { login create(:user) }
      
      context 'with valid fields' do
        scenario 'creates the comment' do
          visit post_path(post)
          fill_in 'comment_body', with: 'This is my comment'
          click_on 'Publish'
          expect(page).to have_content('This is my comment')
        end
      end
    end
  end

  describe 'destroy comment' do
    let!(:user) { create :user }
    let!(:comment) { create :comment, body: 'This is my comment', post: post, user: user }

    context 'user is not logged in' do
      scenario 'redirects to login path' do
        page.driver.delete("/posts/#{post.id}/comments/#{comment.id}")
        expect(page).to have_content('You are being redirected.')
      end
    end
    
    context 'comment owner is logged in' do
      before { login user }

      scenario 'destroys the comment' do
        visit post_path(post)
        click_on 'Remove'
        expect(page).not_to have_content('This is my comment')
      end
    end
  end
end