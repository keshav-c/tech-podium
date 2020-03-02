require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  before do
    @u1 = User.create(username: 'random1', fullname: 'random full')
    @u2 = User.create(username: 'random2', fullname: 'random full')
    @u1.follow(@u2)
  end

  it 'create requires logged in user' do
    post relationships_path
    expect(response).to redirect_to login_path
  end

  it 'destroy requires logged in user' do
    delete relationship_path(@u1.relationship_with(@u2))
    expect(response).to redirect_to login_path
  end
end
