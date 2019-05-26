class UsersController < ApplicationController
   before_action :require_user_logged_in, only: [:index, :show]
   
   # :set_task, only: [:show, :edit, :update, :destroy]
   
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @task = Task.new

    if @user.save
      flash[:success] = 'ユーザを登録しました。ログインして、さっそく使用してみましょう！'
      redirect_to @task
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def gravatar_url(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
  
  private
   
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
