require 'rails_helper'

RSpec.feature 'LikingProcesses', type: :feature do
  before do
    @u1 = User.create(username: 'user1', fullname: 'fname')
    @u2 = User.create(username: 'user2', fullname: 'fname')
    @m1 = @u2.messages.create(text: 'message 1')
    @m2 = @u2.messages.create(text: 'message 2')
    @u1.like_message(@m2)
    visit root_url
    fill_in 'Username', with: @u1.username
    click_button 'Log in'
    visit user_path(@u2)
  end

  it 'User can like a message' do
    expect(page.find("#message-#{@m1.id}")).to have_button('<3', class: 'btn')
    expect(page.find("#message-#{@m1.id}")).to_not have_selector('span.num-likes')
    within(page.find("#message-#{@m1.id}")) do
      click_button '<3'
    end
    expect(page.find("#message-#{@m1.id}")).to have_selector('span.num-likes', text: '1')
    expect(page.find("#message-#{@m1.id}")).to have_button('<3', class: 'btn btn-primary')
  end

  it 'User can undo a message like' do
    expect(page.find("#message-#{@m2.id}")).to have_button('<3', class: 'btn btn-primary')
    expect(page.find("#message-#{@m2.id}")).to have_selector('span.num-likes', text: '1')
    within(page.find("#message-#{@m2.id}")) do
      click_button '<3'
    end
    expect(page.find("#message-#{@m2.id}")).to have_button('<3', class: 'btn')
    expect(page.find("#message-#{@m2.id}")).to_not have_selector('span.num-likes')
  end
end
