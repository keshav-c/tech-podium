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
end
