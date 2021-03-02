require 'rails_helper'

RSpec.feature "Homepage", type: :feature do
  scenario 'displays the index page' do
    visit root_path
    expect(page).to have_content('RECENT POSTS')
  end
end