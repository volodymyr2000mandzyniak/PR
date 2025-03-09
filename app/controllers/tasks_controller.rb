class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]
  rescue_from ArgumentError, with: :handle_invalid_status

  # GET /projects/:project_id/tasks
  def index
    cache_key = "project-#{params[:project_id]}-tasks-#{Task.maximum(:updated_at)}-#{params[:status]}"
    
    @tasks = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      tasks = Task.where(project_id: params[:project_id])
                  .includes(:project)
                  .order(created_at: :desc)
      
      if params[:status].present?
        normalized_status = normalize_status(params[:status])
        tasks = tasks.where(status: normalized_status) if valid_status?(normalized_status)
      end

      tasks.to_a
    end

    render json: @tasks, each_serializer: TaskSerializer
  end

  # GET /tasks/:id
  def show
    render json: @task, serializer: TaskSerializer
  end

  # POST /projects/:project_id/tasks
  def create
    @task = Task.new(task_params)
    @task.project_id = params[:project_id]

    if @task.save
      expire_cache_for(@task.project_id)
      render json: @task, serializer: TaskSerializer, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/:id
  def update
    if params[:task][:status].present?
      params[:task][:status] = normalize_status(params[:task][:status])
    end

    if @task.update(task_params)
      expire_cache_for(@task.project_id)
      render json: @task, serializer: TaskSerializer
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/:id
  def destroy
    project_id = @task.project_id
    @task.destroy
    expire_cache_for(project_id)
    head :no_content
  end

  private

  def expire_cache_for(project_id)
    Rails.cache.delete_matched("project-#{project_id}-tasks-*")
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def normalize_status(status)
    status.downcase
  end

  def task_params
    params.require(:task).permit(:name, :description, :status)
  end

  def valid_status?(status)
    Task.statuses.key?(status)
  end

  # Обробка помилок для невалідного статусу
  def handle_invalid_status(exception)
    if exception.message.include?("'#{task_params[:status]}' is not a valid status")
      render json: { 
        error: "Невірний статус. Дозволені значення: #{Task.statuses.keys.join(', ')}" 
      }, status: :unprocessable_entity
    else
      raise exception
    end
  end

  # Повідомлення про помилку для індексу
  def render_invalid_status_error
    render json: { 
      error: "Невірний статус. Дозволені значення: #{Task.statuses.keys.join(', ')}" 
    }, status: :unprocessable_entity
  end
end