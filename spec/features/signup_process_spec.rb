require 'rails_helper'

RSpec.feature 'SignupProcesses', type: :feature do
  describe 'the sign up page' do
    it 'allows new user creation with valid input data' do
      visit signup_url
      fill_in 'Fullname', with: 'The user one'
      fill_in 'Username', with: 'userone'
      expect(User.count).to eq 0
      click_button 'Sign up'
      expect(page).to have_title('Home | TechPodium')
      expect(User.count).to eq 1
    end
  end
end
