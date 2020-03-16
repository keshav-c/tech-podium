require 'rails_helper'

RSpec.feature 'ViewRelationshipsAuthorized', type: :feature do
  before do
    @u1 = User.create(username: 'User1', fullname: 'The User one')
    @u2 = User.create(username: 'User2', fullname: 'The User two')
    @u3 = User.create(username: 'User3', fullname: 'The User three')
    @u1.follow(@u2)
    @u3.follow(@u1)
    visit login_url
    fill_in 'Username', with: @u1.username
    click_button 'Log in'
  end

  scenario 'authorized user can view their followers' do
    expect(page).to have_content(/1\sfollower/i)
    click_link id: "followers-#{@u1.id}"
    expect(page).to have_content("#{@u1.fullname}'s followers")
    expect(page).to have_css("#user-#{@u3.id}")
    expect(page).to_not have_css("#user-#{@u2.id}")
  end

  scenario 'authorized user can view who they\'re following' do
    expect(page).to have_content(/1\sfollowing/i)
    click_link id: "following-#{@u1.id}"
    expect(page).to have_content("#{@u1.fullname} is following")
    expect(page).to have_css("#user-#{@u2.id}")
    expect(page).to_not have_css("#user-#{@u3.id}")
  end
end
