module SessionHelpers
  def login(user = create!(:user))
    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    find("#login").click
  end
end
