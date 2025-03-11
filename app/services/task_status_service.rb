class TaskStatusService
  STATUSES = {
    new: "new",
    in_progress: "in_progress",
    completed: "completed"
  }.freeze

  def self.valid?(status)
    STATUSES.value?(status)
  end

  def self.normalize(status)
    status.to_s.downcase.strip.gsub(/\s+/, '_')
  end

  def self.validate!(status)
    normalized_status = normalize(status)
    raise ArgumentError, "Invalid status: #{status}" unless valid?(normalized_status)

    normalized_status
  end
end