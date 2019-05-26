class ToppagesController < ApplicationController
 include SessionsHelper    

  def index
     if logged_in?
      @task = current_user.tasks.build  # form_with 用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
     end
  end
end
