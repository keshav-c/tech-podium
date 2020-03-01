require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Fullname and Username should both be valid' do
    user = User.new(fullname: '', username: 'valid')
    expect(user).to_not be_valid
    user = User.new(fullname: 'valid', username: '')
    expect(user).to_not be_valid
    user = User.new(fullname: 'valid', username: 'valid')
    expect(user).to be_valid
  end

  it 'can follow and unfollow another user' do
    u1 = User.create(username: 'user1', fullname: 'u1 full')
    u2 = User.create(username: 'user2', fullname: 'u2 full')
    expect(u1.following?(u2)).to be false
    u1.follow(u2)
    expect(u1.following?(u2)).to be true
    expect(u2.follower?(u1)).to be true
    u1.unfollow(u2)
    expect(u1.following?(u2)).to be false
  end
end
