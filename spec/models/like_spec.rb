require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @u1 = User.create(username: 'user1', fullname: 'The user 1')
    @u2 = User.create(username: 'user2', fullname: 'The user 2')
    @m = @u2.messages.create(text: 'A test message')
  end

  it 'only a valid user can like a message' do
    like = @m.likes.build(user: nil)
    expect(like).to_not be_valid
    like = @m.likes.build(user_id: @u1.id + 1000)
    expect(like).to_not be_valid
  end

  it 'user cannot like invalid message' do
    like = Like.new(user: @u1, message: nil)
    expect(like).to_not be_valid
    like = Like.new(user: @u1, message_id: @m.id + 1000)
    expect(like).to_not be_valid
  end

  it 'user can like a valid message' do
    like1 = Like.new(user: @u1, message: @m)
    expect(like1).to be_valid
    like2 = @m.likes.build(user: @u1)
    expect(like2).to be_valid
  end

  it 'user cannot like the same message twice' do
    @u1.like_message(@m)
    like = @m.likes.build(user: @u1)
    expect(like).to_not be_valid
  end
end
