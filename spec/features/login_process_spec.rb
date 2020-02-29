require 'rails_helper'

RSpec.feature 'LoginProcesses', type: :feature do
  describe 'visit homepage' do
    before do
      @user = User.create(username: 'userone', fullname: 'The user one')
    end

    it 'if not logged in redirects to login page' do
      visit root_url
      expect(page).to have_title('Log in | TechPodium')
    end

    it 'On log in, shows the user\'s home page' do
      visit login_url
      fill_in 'Username', with: @user.username
      click_button 'Log in'
      expect(page).to have_title('Home | TechPodium')
    end

    it 'logged in user can logout' do
      visit login_url
      fill_in 'Username', with: @user.username
      click_button 'Log in'
      visit user_path(@user)
      click_link 'Log out'
      expect(page).to have_title('Log in | TechPodium')
    end
  end
end
