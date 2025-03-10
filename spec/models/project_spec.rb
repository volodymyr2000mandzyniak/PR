require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'is invalid without a name' do
    project = build(:project, name: nil)
    expect(project).not_to be_valid
  end

  it 'is invalid with a long name' do
    project = build(:project, name: 'a' * 101)
    expect(project).not_to be_valid
  end

  it 'is invalid without a description' do
    project = build(:project, description: nil)
    expect(project).not_to be_valid
  end

  it 'is invalid with a long description' do
    project = build(:project, description: 'a' * 501)
    expect(project).not_to be_valid
  end
end
