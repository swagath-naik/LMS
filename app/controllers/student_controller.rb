class StudentController < ApplicationController
  before_action :require_login 
  def show
	#@profile=AdminProfile.find(params[:id])
	@user=User.find_by(profile_id: params[:id], profile_type: "StudentProfile")
  end

  def search
	#@profile=AdminProfile.find(params[:id])
	@user=User.find_by(profile_id: params[:id], profile_type: "StudentProfile")
 
  end

  def indexBookIssue
    @user=User.find_by(profile_id: params[:id], profile_type: "StudentProfile")

    @bookIssue = BookIssue.where("username = ?",@user.username)
    @books=Book.all
  end

  def searchResult
	@user=User.find_by(profile_id: params[:id], profile_type: "StudentProfile")
  	searchKey = params[:searchKey]
    if  searchKey==nil
    redirect_to '/student/'+current_user.profile_id.to_s and return
    end  
  	
  	@bookResults = Book.where("lower(title) = ? OR lower(author) = ?",searchKey.downcase,searchKey.downcase)
  
  	
  	 	
  	render 'searchResult'
  	
  	#redirect_to controller:"parcels", action: "show", id: parcel_location
  end

end
