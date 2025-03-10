require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'is invalid without a name' do
    task = build(:task, name: nil)
    expect(task).not_to be_valid
  end

  it 'is invalid with a long name' do
    task = build(:task, name: 'a' * 101)
    expect(task).not_to be_valid
  end

  it 'is invalid without a description' do
    task = build(:task, description: nil)
    expect(task).not_to be_valid
  end

  it 'is invalid with a long description' do
    task = build(:task, description: 'a' * 501)
    expect(task).not_to be_valid
  end

  it 'accepts valid statuses' do
    valid_statuses = [:new, :in_progress, :completed]
    valid_statuses.each do |status|
      task = build(:task, status: status)
      expect(task).to be_valid
    end
  end

  it 'assigns the correct status' do
    task = build(:task, status: :new)
    expect(task.status).to eq('new')
  end
end
