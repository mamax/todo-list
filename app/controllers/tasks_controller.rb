class TasksController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update, :destroy, :done]

  def index
    @tasks = Task.order("position")
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        flash[:success] = "Task added!"
        format.html { redirect_to root_path}
      else
        flash[:error] = "Can't be blank or should be less than 100 characters"
        format.html { redirect_to root_path }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to root_path}
        flash[:success] = "Task edited!"
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "Task deleted!"
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def sort
    params[:task].each_with_index do |id, index|
      Task.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  def done
    @task.update_attributes(done: params[:done])
    render nothing: true
  end

  private

  def correct_user
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :project_id, :done, :position)
  end
end
