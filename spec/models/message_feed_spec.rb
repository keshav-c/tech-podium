require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @u1 = User.create(username: 'user1', fullname: 'The User One')
    @u2 = User.create(username: 'user2', fullname: 'The User Two')
    @u1.follow(@u2)
    @m1 = @u1.messages.create(text: 'text', created_at: 3.hours.ago)
    @m2 = @u1.messages.create(text: 'text', created_at: 1.hours.ago)
    @m3 = @u2.messages.create(text: 'text', created_at: 4.hours.ago)
    @m4 = @u2.messages.create(text: 'text', created_at: 2.hours.ago)
    @u1.like_message(@m2)
    @u1.like_message(@m4)
  end

  it 'feed gets liked status, and like :id (if liked) for messages in current user\'s feed' do
    feed = Message.feed(@u1, current_user: @u1)
    expect(feed.length).to eq 4
    expect(feed[0].liked).to be true
    expect(feed[0].like_id).to eq Like.find_by(user_id: @u1.id, message_id: @m2.id).id
    expect(feed[1].liked).to be true
    expect(feed[1].like_id).to eq Like.find_by(user_id: @u1.id, message_id: @m4.id).id
    expect(feed[2].liked).to be false
    expect(feed[2].like_id).to be nil
    expect(feed[3].liked).to be false
    expect(feed[3].like_id).to be nil
  end

  it 'feed gets liked status, and like :id (if liked) for messages in another user\'s feed' do
    feed = Message.feed(@u2, current_user: @u1)
    expect(feed.length).to eq 2
    expect(feed[0].liked).to be true
    expect(feed[0].like_id).to eq Like.find_by(user_id: @u1.id, message_id: @m4.id).id
    expect(feed[1].liked).to be false
    expect(feed[1].like_id).to be nil
  end
end
