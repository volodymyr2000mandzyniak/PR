# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /projects/:project_id/tasks
  def index
    @tasks = Task.where(project_id: params[:project_id])
    render json: @tasks
  end

  # GET /tasks/:id
  def show
    render json: @task
  end

  # POST /projects/:project_id/tasks
  def create
    @task = Task.new(task_params)
    @task.project_id = params[:project_id]

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/:id
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/:id
  def destroy
    @task.destroy
    head :no_content
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :status)
  end
end