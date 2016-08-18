class SharesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	
  def new
    @share = Share.new
  end

  def index
   @shares = Share.newest
   @share = Share.new
   gon.share_title = @shares.to_json

  end



  def create
   @share = current_user.shares.create(share_params)
   if @share.valid?
    redirect_to shares_path
   else
    render :new, status: :unprocessable_entity
   end
  end

  def show
   @share = Share.find_by_id(params[:id])
   return render_not_found if @share.blank?
   @comment = Comment.new

  end

  def edit
   @share = Share.find_by_id(params[:id])
   return render_not_found if @share.blank?
   return render_not_found(:forbidden) if @share.user != current_user
  end

  def update
   @share = Share.find_by_id(params[:id])
   return render_not_found if @share.blank?
   return render_not_found(:forbidden) if @share.user != current_user
	  
   @share.update_attributes(share_params)
   if @share.valid?
    redirect_to shares_path
   else
    return render :edit, status: :unprocessable_entity
   end
  end

  def destroy
   @share = Share.find_by_id(params[:id])
   return render_not_found if @share.blank?
   return render_not_found(:forbidden) if @share.user != current_user
   @share.destroy
   redirect_to shares_path 
  end

  def upvote
   @share = Share.find(params[:id])
   @share.votes.create
   redirect_to shares_path
  end

  private

  def share_params
   params.require(:share).permit(:body, :title)
  end


end
