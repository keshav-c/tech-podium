require 'rails_helper'

RSpec.feature 'MessageFeeds', type: :feature do
  before do
    @us = (1..3).to_a.map { |n| User.create(username: "user#{n}", fullname: "The User #{n}") }
    @ms = []
    diff = 1
    @us.each do |u|
      @ms << u.messages.create(text: "Message by #{u.fullname}", created_at: diff.hours.ago)
      diff += 1
    end
    @us[0].follow(@us[1])
    visit login_url
    fill_in 'Username', with: @us[0].username
    click_button 'Log in'
  end

  it 'logged in user profile shows messages by self and by following users in correct order' do
    expect(page.find('.message-feed li:nth-child(1)')).to have_selector("#message-#{@ms[0].id}")
    expect(page.find('.message-feed li:nth-child(2)')).to have_selector("#message-#{@ms[1].id}")
    expect(page).to_not have_selector("#message-#{@ms[2].id}")
  end

  it 'other user profile shows only messages by other user in correct order' do
    @us[1].follow(@us[2])
    m = @us[1].messages.create(text: "Another message by #{@us[1].fullname}")
    visit user_path(@us[1])
    expect(page.find('.message-feed li:nth-child(1)')).to have_selector("#message-#{m.id}")
    expect(page.find('.message-feed li:nth-child(2)')).to have_selector("#message-#{@ms[1].id}")
    expect(page).to_not have_selector("#message-#{@ms[2].id}")
  end
end
