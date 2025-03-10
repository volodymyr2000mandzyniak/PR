require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without a password' do
    user = build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it 'is invalid with a short password' do
    user = build(:user, password: 'short')
    expect(user).not_to be_valid
  end

  it 'is invalid without a password confirmation' do
    user = build(:user, password_confirmation: nil)
    expect(user).not_to be_valid
  end

  it 'generates a JTI on create' do
    user = create(:user)
    expect(user.jti).not_to be_nil
  end
end
