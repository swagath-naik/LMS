class FacultyController < ApplicationController
  def show
	#@profile=AdminProfile.find(params[:id])
	@user=User.find_by(profile_id: params[:id], profile_type: "FacultyProfile")
  end
end
