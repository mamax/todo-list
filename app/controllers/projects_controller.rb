class ProjectsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy, :update, :edit]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to root_path
    else
      render 'projects/new'
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to root_path }
        flash[:success] = "Project edited!"
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = "Project deleted!"
    else
      render 'projects/new'
    end
    redirect_to root_path
  end

  private
  def project_params
    params.require(:project).permit(:name)
  end

  def correct_user
    @project = current_user.projects.find_by(id: params[:id])
    redirect_to root_path if @project.nil?
  end

end