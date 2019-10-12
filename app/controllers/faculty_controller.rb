class FacultyController < ApplicationController
  def show
	#@profile=AdminProfile.find(params[:id])
	@user=User.find_by(profile_id: params[:id], profile_type: "FacultyProfile")
  end

   def search
	#@profile=AdminProfile.find(params[:id])
	@user=User.find_by(profile_id: params[:id], profile_type: "FacultyProfile")
 
  end

  def indexBookIssue
    @user=User.find_by(profile_id: params[:id], profile_type: "FacultyProfile")

    @bookIssue = BookIssue.where("username = ?",@user.username)
    @books=Book.all
  end

  def searchResult
	@user=User.find_by(profile_id: params[:id], profile_type: "FacultyProfile")
  	searchKey = params[:searchKey]
  	
  	@bookResults = Book.where("lower(title) = ? OR lower(author) = ?",searchKey.downcase,searchKey.downcase)
  
  	
  	 	
  	render 'searchResult'
  	
  	#redirect_to controller:"parcels", action: "show", id: parcel_location
  end

end
