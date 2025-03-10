class Task < ApplicationRecord
  belongs_to :project, touch: true

  STATUSES = %w[new in_progress completed].freeze

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :status, inclusion: { in: STATUSES, message: "Невірний статус. Дозволені значення: #{STATUSES.join(', ')}" }

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