require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  before do
    @user = User.create(username: 'mainuser', fullname: 'The main man')
    @another = User.create(username: 'another', fullname: 'The some dude')
    visit login_url
    fill_in 'Username', with: @user.username
    click_button 'Log in'
  end

  scenario 'logged in user, on visiting root url, is shown profile page' do
    visit user_url(@another)
    expect(page).to have_content(@another.fullname)
    visit root_url
    expect(page).to have_content(@user.fullname)
  end
end
