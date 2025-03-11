class Task < ApplicationRecord
  belongs_to :project, touch: true

  enum status: { new: 'new', in_progress: 'in_progress', completed: 'completed' }, _suffix: true

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :status, inclusion: { in: TaskStatusService::STATUSES.values }

  before_validation :set_default_status, on: :create
  before_validation :normalize_status

  private

  def set_default_status
    self.status ||= 'new'
  end

  def normalize_status
    self.status = status.to_s.downcase if status.present?
  end
end