class SessionsController < ApplicationController
  def new
  end

  def create
        user = User.find_by_username(params[:username])   
        if user && user.authenticate(params[:password])   
          session[:user_id] = user.id
	  redirect_to '/admin/'+user.profile_id.to_s,  if user.profile_type == "AdminProfile"
	  redirect_to '/student/'+user.profile_id.to_s, if user.profile_type == "StudentProfile"
	  redirect_to '/faculty/'+user.profile_id.to_s, if user.profile_type == "FacultyProfile"
          #redirect_to root_url, notice: 'Logged in!'   
        else   
          render :new   
        end 
  end

  def destroy
        session[:user_id] = nil   
        redirect_to root_url #, notice: 'Logged out!'
  end
end
