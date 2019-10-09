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
  end

  # POST /users
  def create

    if params[:role] == 'admin'
	then
        @user = User.create! do |u|
		u.username = params[:user][:username]
		u.password = params[:user][:password]
		u.password_confirmation = params[:user][:password_confirmation]
		u.profile = AdminProfile.create! do |p|
			p.key = params[:user][:key]
			end
		end

    elsif params[:role] == 'student'
	then
        @user = User.create! do |u|
		u.username = params[:user][:username]
		u.password = params[:user][:password]
		u.password_confirmation = params[:user][:password_confirmation]
		u.profile = StudentProfile.create! do |p|
			p.sname = params[:user][:sname]
			end
		end

    elsif params[:role] == 'faculty'
	then
        @user = User.create! do |u|
		u.username = params[:user][:username]
		u.password = params[:user][:password]
		u.password_confirmation = params[:user][:password_confirmation]
		u.profile = FacultyProfile.create! do |p|
			p.fname = params[:user][:fname]
			p.fdes = params[:user][:fdes]
			end
		end
        end
puts(@user)
      session[:user_id] = @user.id
      redirect_to '/admin/'+@user.profile_id.to_s, notice: 'User was successfully created.' if params[:role] == 'admin'
      redirect_to '/student/'+@user.profile_id.to_s, notice: 'User was successfully created.' if params[:role] == 'student'
      redirect_to '/faculty/'+@user.profile_id.to_s, notice: 'User was successfully created.' if params[:role] == 'faculty'

  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      #params.require(:user).permit(:username, :role, :password, :password_confirmation)
      params.require(:user).permit(:username, :role, :password, :password_confirmation, :key)
    end
end
