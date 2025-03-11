class TaskCacheService
  def self.fetch_tasks(project_id, status)
    cache_key = "project-#{project_id}-tasks-#{Task.maximum(:updated_at)}-#{status}"
    Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      tasks = Task.where(project_id: project_id).includes(:project).order(created_at: :desc)
      tasks = tasks.where(status: TaskStatusService.normalize(status)) if status.present?
      tasks.to_a
    end
  end

  def self.expire_cache(project_id)
    Rails.cache.delete_matched("project-#{project_id}-tasks-*")
  end
end
