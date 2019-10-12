class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  @user = User.find_by id: params[:id]
  end

  # POST /users
  def create
    @user = User.new
    	if params[:role] == 'admin'
        	@user = User.new do |u|
			u.profile = AdminProfile.new
			u.username = params[:user][:username]
			u.password = params[:user][:password]
			u.password_confirmation = params[:user][:password_confirmation]
		
			end
			if params[:user][:key] == admin_key
     				@user.save
				#render :new and return unless @user.valid?
			else
				@user.valid?
				@user.errors.add("Admin Key", "Invalid")
				render :new and return
			end

    elsif params[:role] == 'student'
			puts(params)
	        	@user = User.new do |u|
			u.username = params[:user][:username]
			u.password = params[:user][:password]
			u.password_confirmation = params[:user][:password_confirmation]
			u.profile = StudentProfile.new do |p|
			p.sname = params[:user][:sname]
				end
			end
			puts("L2 #{@user.profile.valid?}")
			puts("L1 #{@user.valid?}")
			if @user.profile.valid? and @user.valid?
				@user.save
			else
				render :new and return
			end

    elsif params[:role] == 'faculty'
	then
        @user = User.new do |u|
			u.username = params[:user][:username]
			u.password = params[:user][:password]
			u.password_confirmation = params[:user][:password_confirmation]
			u.profile = FacultyProfile.new do |p|
			p.fname = params[:user][:fname]
			p.fdes = params[:user][:fdes]
				end
			end
			@user.profile.valid?
			@user.valid?
			if @user.profile.valid? and @user.valid?
				@user.save
			else
				render :new and return
			end
        
    else
		@user.username = params[:user][:username]
		@user.password = params[:user][:password]
		@user.password_confirmation = params[:user][:password_confirmation]
		@user.valid?
		@user.errors.add("User Profile", "must be selected (Admin/Student/Faculty)")
		render :new and return
    end
	render :new and return unless @user.valid?
	session[:user_id] = @user.id
	#redirect_to '/admin/'+@user.profile_id.to_s, notice: 'User was successfully created.' if params[:role] == 'admin'
	#redirect_to '/student/'+@user.profile_id.to_s, notice: 'User was successfully created.' if params[:role] == 'student'
	#redirect_to '/faculty/'+@user.profile_id.to_s, notice: 'User was successfully created.' if params[:role] == 'faculty'
	redirect_to user_home
  end

  # PATCH/PUT /users/1
  def update

    @user = User.find_by id: params[:id]
    if @user.profile_type == "AdminProfile"
   	 	@user.password = params[:user][:password]
    		@user.password_confirmation = params[:user][:password_confirmation]
		if @user.authenticate(params[:old_password])
			if @user.save
				redirect_to user_home, notice: 'User Profile was successfully updated.'
			else
				render :edit and return
			end
			
        	else
     	 		render :edit and return
   		end
     end
    if @user.profile_type == "StudentProfile"
   	 	@user.password = params[:user][:password]
    		@user.password_confirmation = params[:user][:password_confirmation]
		@user.profile.sname = params[:user][:sname]
		raise params.inspect
		if @user.authenticate(params[:old_password])
			if @user.save
				redirect_to user_home, notice: 'User Profile was successfully updated.'
			else
				render :edit and return
			end
			
        	else
     	 		render :edit and return
   		end
     end


    if @user.profile_type == "FacultyProfile"
   	 	@user.password = params[:user][:password]
    		@user.password_confirmation = params[:user][:password_confirmation]
		if @user.authenticate(params[:old_password])
			if @user.save
				redirect_to user_home, notice: 'User Profile was successfully updated.'
			else
				render :edit and return
			end
			
        	else
     	 		render :edit and return
   		end
     end

  end
  

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to root_path, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      #params.require(:user).permit(:username, :role, :password, :password_confirmation)
      params.require(:user).permit(:username, :role, :password, :password_confirmation)
    end
end
