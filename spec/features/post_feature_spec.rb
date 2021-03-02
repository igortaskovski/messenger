require 'rails_helper'

RSpec.feature "Post", type: :feature do
  describe 'new article' do
    context 'user is not logged in' do
      scenario 'redirects to login path' do
        visit new_post_path
        expect(page).not_to have_content('New post')
        expect(page).to have_content('Login Register')
      end
    end
    
    context 'user is logged in' do
      before { login create(:user) }
      
      context 'with invalid fields' do
        scenario 'shows errors' do
          visit new_post_path
          expect(page).to have_content('Create a new post')
          fill_in 'Title', with: Faker::Lorem.paragraph
          click_on 'Publish'
          expect(page).to have_content("Body can't be blank")
          fill_in 'post_title', with: 'Abc'
          click_on 'Publish'
          expect(page).to have_content ('Title is too short (minimum is 5 characters)')
        end
      end
      
      context 'with valid fields' do
        scenario 'creates the post' do
          visit new_post_path
          expect(page).to have_content('Create a new post')
          fill_in 'Title', with: 'Special Post'
          fill_in 'post_body', with: 'This is my post content.'
          click_on 'Publish'
          expect(page).to have_content('Special Post')
          expect(page).to have_content('This is my post content.')
        end
      end
    end
  end

  describe 'edit post' do
    let!(:user) { create :user }
    let!(:post) { create :post, title: 'Exciting News', user: user }
    
    context 'user is not logged in' do
      scenario 'redirects to login path' do
        visit edit_post_path(post)
        expect(page).not_to have_content('Edit post')
        expect(page).to have_content('Login Register')
      end
    end
    
    context 'non-post owner is logged in' do
      before { login create(:user) }
      
      scenario 'cannot edit other posts' do
        visit edit_post_path(post)
        expect(page).not_to have_content('Edit post')
        expect(page).to have_content('RECENT POSTS')
      end
    end
    
    context 'post owner is logged in' do
      before { login user }
      
      context 'with invalid fields' do
        scenario 'shows errors' do
          visit edit_post_path(post)
          fill_in 'Title', with: ''
          click_on 'Publish'
          expect(page).to have_content("Title can't be blank")
          fill_in 'Title', with: 'Abc'
          click_on 'Publish'
          expect(page).to have_content ('Title is too short (minimum is 5 characters)')
        end
      end
      
      context 'with valid fields' do
        scenario 'updates the post' do
          visit edit_post_path(post)
          fill_in 'Title', with: 'Lorem Ipsum is simply dummy'
          click_on 'Publish'
          expect(page).to have_content('Lorem Ipsum is simply dummy')
          expect(page).not_to have_content('five centuries, but also the leap')
        end
      end
    end
  end

  describe 'destroy post' do
    let!(:user) { create :user }
    let!(:post) { create :post, title: 'Exciting News', user: user }
    
    context 'user is not logged in' do
      scenario 'redirects to login path' do
        page.driver.delete("/posts/#{post.id}")
        expect(page).to have_content('You are being redirected.')
      end
    end
  end

  describe 'show post' do
    let!(:post) { create :post, title: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.', body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry." }

    scenario 'shows the post' do
      visit posts_path
      click_on 'Read More'
      expect(page).to have_content('Lorem Ipsum is simply dummy text of the printing and typesetting industry.')
    end
  end
end