require 'rails_helper'

RSpec.feature "LoginProcesses", type: :feature do
  describe 'visit homepage' do
    it 'if not logged in redirects to login page' do
      visit root_url
      expect(page).to have_title("Log in | TechPodium")
    end

    it 'if logged in, shows the user\'s home page' 
  end
end
