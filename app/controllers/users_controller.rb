class UsersController < ApplicationController
	
	def show
		@user = User.find(params[:id])
    
	end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(theme: params[:theme])
    if @user.valid?
    flash[:notice] = "Your theme was updated."
    redirect_to user_path
   else
    return render :edit, status: :unprocessable_entity
   end

  end
 
 private

 def user_params
  params.require(:user).permit(:theme)
 end

end


