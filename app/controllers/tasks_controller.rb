class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show update destroy]
  rescue_from ArgumentError, with: :handle_invalid_status

  # GET /projects/:project_id/tasks
  def index
    @tasks = TaskCacheService.fetch_tasks(params[:project_id], params[:status])
    render json: @tasks, each_serializer: TaskSerializer
  end

  # GET /tasks/:id
  def show
    render json: @task, serializer: TaskSerializer
  end

  # POST /projects/:project_id/tasks
  def create
    @task = Task.new(task_params.merge(project_id: params[:project_id]))

    if @task.save
      TaskCacheService.expire_cache(@task.project_id)
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/:id
  def update
    if @task.update(task_params)
      TaskCacheService.expire_cache(@task.project_id)
      render json: @task, serializer: TaskSerializer
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/:id
  def destroy
    project_id = @task.project_id
    @task.destroy
    TaskCacheService.expire_cache(project_id)
    head :no_content
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :status).tap do |task_params|
      task_params[:status] = TaskStatusService.validate!(task_params[:status]) if task_params[:status].present?
    end
  end

  def handle_invalid_status(exception)
    render json: { error: "Invalid status. Allowed values: #{Task.statuses.keys.join(', ')}" }, status: :unprocessable_entity
  end
end