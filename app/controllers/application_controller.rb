class ApplicationController < ActionController::Base   
  protect_from_forgery with: :exception   
  private   
  def current_user   
    User.where(id: session[:user_id]).first   
  end
  def admin_key  
    "123456"   
  end
  def user_home
    return '/admin/'+current_user.profile_id.to_s   if current_user.role=="admin"
    return '/faculty/'+current_user.profile_id.to_s if current_user.role=="faculty"
    return '/student/'+current_user.profile_id.to_s   if current_user.role=="student"
    return "/"
     
  end
    
  helper_method :current_user, :admin_key, :user_home
end
