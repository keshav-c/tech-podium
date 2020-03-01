require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @user = User.create(fullname: 'The User', username: 'mruser')
  end

  it 'is invalid with no content' do
    msg = @user.messages.build(text: nil)
    expect(msg).to_not be_valid
  end

  it 'is invalid with no user' do
    msg = Message.create(text: 'some text here')
    expect(msg).to_not be_valid
  end

  it 'is invalid if too long(> 300 characters)' do
    msg = @user.messages.build(text: 'a' * 301)
    expect(msg).to_not be_valid
  end

  it 'needs valid user, in order to be created' do
    msg = @user.messages.build(text: 'a' * 300)
    expect(msg).to be_valid
  end
end
