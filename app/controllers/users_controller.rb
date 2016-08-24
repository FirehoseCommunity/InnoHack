class UsersController < ApplicationController

  before_filter :set_user

  def show
		@user = User.find_by_id(params[:id])
	end

  def follow
    current_user.follow!(@user)
    redirect_to root_path
  end

  def unfollow
    current_user.unfollow!(@user)
    redirect_to 
  end

private
  def set_user
    @user = User.find_by_id(params[:id])
  end  
end
