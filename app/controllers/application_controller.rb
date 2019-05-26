class ApplicationController < ActionController::Base

  
  include SessionsHelper
  
  private


  
  def counts(user)
    @count_tasks = user.tasks.count
  end
  

  
end
