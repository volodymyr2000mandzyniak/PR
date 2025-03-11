class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    cache_key = "projects/#{current_user.id}/#{Project.maximum(:updated_at)}"
    
    @projects = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      current_user.projects.preload(:tasks)
                  .select(:id, :name, :description, :created_at, :updated_at)
                  .order(created_at: :desc).to_a
    end
    
    render json: @projects, each_serializer: ProjectSerializer
  end

  # GET /projects/:id
  def show
    if @project.user_id == current_user.id
      render json: @project, serializer: ProjectSerializer
    else
      render json: { error: "You are not authorized to access this project" }, status: :forbidden
    end
  end

  # POST /projects
  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      render json: @project, serializer: ProjectSerializer, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/:id
  def update
    if @project.user_id == current_user.id
      if @project.update(project_params)
        render json: @project, serializer: ProjectSerializer
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "You are not authorized to update this project" }, status: :forbidden
    end
  end

  # DELETE /projects/:id
  def destroy
    if @project.user_id == current_user.id
      @project.destroy
      head :no_content
    else
      render json: { error: "You are not authorized to delete this project" }, status: :forbidden
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end