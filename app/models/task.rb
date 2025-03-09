class Task < ApplicationRecord
  belongs_to :project, touch: true

  # before_destroy { project.touch } # Оновлення проекту при видаленні завдання


  enum status: {
    new: 'new',
    in_progress: 'in_progress', 
    completed: 'completed'
  }, _prefix: :status, _default: :not_started

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :status, inclusion: { in: statuses.keys }

  before_validation :normalize_status

  private

  def normalize_status
    self.status = status.downcase if status.present?
  end
end