class TasksController < ApplicationController
 #ログインしていないユーザーにはタスク管理を使用させない。
 before_action :login_required
 before_action :set_task, only: [:show, :edit, :update, :destroy]
 
 #ログインしていないユーザーはLogin画面へ戻る。
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def login_required
    redirect_to login_path unless current_user
  end
 
  def index
      @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
      @task =Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Taskは正常に更新されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskは更新されませんでした'
      render :edit
    end  
  end
    
  def destroy
    @task.destroy
    flash[:success] = 'Taskは正常に削除されました。'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = current_user.tasks.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end