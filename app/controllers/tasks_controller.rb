class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :done]

  # GET /tasks
  def index
    @tasks = Task.order("position")
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        flash[:success] = "Task added!"
        format.html { redirect_to root_path}
      else
        flash[:alert] = "Content can't be blank or Content is to long (maximim is 70 characters)"
        format.html { redirect_to root_path }
      end
    end
  end

  # PATCH/PUT /tasks/1
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

  # DELETE /tasks/1
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
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:content, :project_id, :done, :position)
  end
end
