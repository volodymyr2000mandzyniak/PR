class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    cache_key = "projects/#{Project.maximum(:updated_at)}"
    
    @projects = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      Project.preload(:tasks)
            .select(:id, :name, :description, :created_at, :updated_at)
            .order(created_at: :desc).to_a
    end
    
    render json: @projects, each_serializer: ProjectSerializer
  end

  # GET /projects/:id
  def show
    render json: @project, serializer: ProjectSerializer
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    if @project.save
      render json: @project, serializer: ProjectSerializer, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/:id
  def update
    if @project.update(project_params)
      render json: @project, serializer: ProjectSerializer
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy
    head :no_content
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end