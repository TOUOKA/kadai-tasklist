class ApplicationController < ActionController::Base
  #before_action :login_required
  
  include SessionsHelper
  
 def require_user_logged_in
    unless logged_in?
     redirect_to login_url
    end
 end
  
  private

  def login_required
     redirect_to login_path unless current_user
  end
  
  def counts(user)
    @count_tasks = user.tasks.count
  end
  

  
end
