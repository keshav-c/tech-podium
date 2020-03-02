require 'rails_helper'

RSpec.feature 'ViewRelationshipsUnauthorized', type: :feature do
  before do
    @u1 = User.create(username: 'User1', fullname: 'The User one')
    @u2 = User.create(username: 'User2', fullname: 'The User two')
    @u3 = User.create(username: 'User3', fullname: 'The User three')
    @u1.follow(@u2)
    @u3.follow(@u1)
  end

  scenario 'unauthorized user cannot view followers page' do
    visit followers_user_path(@u1)
    expect(page).to have_title('Log in | TechPodium')
  end

  scenario 'unauthorized user cannot view following page' do
    visit following_user_path(@u2)
    expect(page).to have_title('Log in | TechPodium')
  end
end
