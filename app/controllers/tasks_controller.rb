class TasksController < ApplicationController
  def new
    @task = Task.new
    render :show_task_modal
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    authorize! :create, @task
    save_task
  end

  def edit
    @task = Task.find(params[:id])
    authorize! :edit, @task
    render :show_task_modal
  end

  def update
    @task = Task.find(params[:id])
    @task.assign_attributes(task_params)
    authorize! :update, @task
    save_task
  end

  def delete
    @task = Task.find(params[:task_id])
    authorize! :edit, @task
    render :delete_task_modal
  end

  def destroy
    @task = Task.find(params[:id])
    authorize! :destroy, @task
    @task.destroy
    @tasks = Task.accessible_by(current_ability).all
    render :hide_task_delete
  end

  private

  def save_task
    if @task.save
      @tasks = Task.accessible_by(current_ability).all
      render :hide_task_modal
    else
      render :show_task_modal
    end
  end

  def task_params
    params.require(:task).permit(:title, :note, :completed)
  end
end
