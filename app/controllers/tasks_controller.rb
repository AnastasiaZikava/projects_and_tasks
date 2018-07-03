class TasksController < ApplicationController
  before_action :set_admin, only: [:destroy, :create]
  before_action :set_task, only: [:new, :edit, :create, :update, :destroy]
  
  def new
    @task = @project.tasks.new
  end

  def edit
    begin
      @task = Task.find(params[:id])
    rescue => exception
      redirect_to projects_url
    end   
  end
  
  def create
    @task = @project.tasks.create(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_path(@project)}
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_path(@project)
  end

  def update   
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(task_params)
        format.html { redirect_to project_path(@project)}
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def set_admin
    unless current_user.admin?
      redirect_to projects_url
    end
  end

  def set_task
    begin
      @project = Project.find(params[:project_id])
    rescue
      redirect_to projects_url
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :user_id)
  end
end
