require 'rails_helper'

RSpec.feature 'FollowingProcesses', type: :feature do
  before do
    @u1 = User.create(username: 'user1', fullname: 'The User One')
    @u2 = User.create(username: 'user2', fullname: 'The User Two')
    visit login_url
    fill_in 'Username', with: @u1.username
    click_button 'Log in'
  end

  scenario 'authorized user can follow another user' do
    visit user_path(@u2)
    expect(page).to have_button('Follow')
    expect(@u1.following.count).to eq 0
    expect(@u2.followers.count).to eq 0
    click_button 'Follow'
    expect(page).to have_button('Unfollow')
    expect(@u1.following.count).to eq 1
    expect(@u2.followers.count).to eq 1
  end

  scenario 'authorized user can unfollow previously followed user' do
    @u1.follow(@u2)
    visit user_path(@u2)
    expect(page).to have_button('Unfollow')
    expect(@u1.following.count).to eq 1
    expect(@u2.followers.count).to eq 1
    click_button 'Unfollow'
    expect(page).to have_button('Follow')
    expect(@u1.following.count).to eq 0
    expect(@u2.followers.count).to eq 0
  end
end
