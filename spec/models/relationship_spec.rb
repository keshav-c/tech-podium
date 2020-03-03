require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @u1 = User.create(username: 'user1', fullname: 'u1 full')
    @u2 = User.create(username: 'user2', fullname: 'u2 full')
  end

  it 'is valid between two distinct users' do
    rel = Relationship.new(follower_id: @u1.id, followed_id: @u2.id)
    expect(rel).to be_valid
  end

  it 'is invalid without valid follower' do
    rel = Relationship.new(follower_id: nil, followed_id: @u2.id)
    expect(rel).to_not be_valid
    rel = Relationship.new(follower_id: @u1.id + 1000, followed_id: @u2.id)
    expect(rel).to_not be_valid
  end

  it 'is invalid without valid followed' do
    rel = Relationship.new(follower_id: @u1.id, followed_id: nil)
    expect(rel).to_not be_valid
    rel = Relationship.new(follower_id: @u1.id, followed_id: @u2.id + 1000)
    expect(rel).to_not be_valid
  end

  it 'cannot follow the same user twice' do
    rel = Relationship.new(follower_id: @u1.id, followed_id: @u2.id)
    expect(rel).to be_valid
    rel.save
    dup_rel = Relationship.new(follower_id: @u1.id, followed_id: @u2.id)
    expect(dup_rel).to_not be_valid
  end
end
