require 'rails_helper'

RSpec.feature 'MessagingProcesses', type: :feature do
  describe 'Posting from own page' do
    before do
      @user = User.create(username: 'userone', fullname: 'The user one')
      visit login_url
      fill_in 'Username', with: @user.username
      click_button 'Log in'
    end

    scenario 'user can create a message from their home page' do
      within('.messaging-form') do
        fill_in name: 'message[text]', with: 'This is a new post'
      end
      click_button 'Post'
      expect(page).to have_content('This is a new post')
    end
  end

  scenario 'user can message another user from their profile page'
end
