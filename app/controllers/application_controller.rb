class ApplicationController < ActionController::Base   
  protect_from_forgery with: :exception  

  
  def require_login
    @cu=User.where(id: session[:user_id]).first
    
    if @cu==nil
    flash[:danger]="Please Login ! "
    redirect_to '/'
    end
  end

  private   
  def current_user   
    User.where(id: session[:user_id]).first   
  end
  def admin_key  
    "123456"   
  end
  def user_home
    return '/admin/'+current_user.profile_id.to_s     if current_user and current_user.role=="admin"
    return '/faculty/'+current_user.profile_id.to_s   if current_user and current_user.role=="faculty"
    return '/student/'+current_user.profile_id.to_s   if current_user and current_user.role=="student"
    return "/"
     
  end
    
  helper_method :current_user, :admin_key, :user_home
end
