require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  before do
    @u1 = User.create(username: 'user1', fullname: 'The user 1')
    @u2 = User.create(username: 'user2', fullname: 'The user 2')
    @m = @u2.messages.create(text: 'A test message')
    @u1.like_message(@m)
  end

  it 'create requires logged in user' do
    post likes_path
    expect(response).to redirect_to login_path
  end

  it 'destroy requires logged in user' do
    delete like_path(Like.find_by!(user_id: @u1.id, message_id: @m.id))
    expect(response).to redirect_to login_path
  end
end
