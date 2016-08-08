class SharesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_share, only: [:show, :edit, :update, :destroy, :upvote]

  def index
   @shares = Share.newest
  end

  def new
   @share = Share.new
  end

  def create
   @share = current_user.shares.create(share_params)
   if @share.valid?
    flash[:notice] = "Your code share was added."
    redirect_to shares_path
   else
    render :new, status: :unprocessable_entity
   end
  end

  def show
   return render_not_found if @share.blank?
   @comment = Comment.new
  end

  def edit
   return render_not_found if @share.blank?
   return render_not_found(:forbidden) if @share.user != current_user
  end

  def update
   return render_not_found if @share.blank?
   return render_not_found(:forbidden) if @share.user != current_user

   @share.update_attributes(share_params)
   if @share.valid?
    flash[:notice] = "Your code share was updated."
    redirect_to shares_path
   else
    return render :edit, status: :unprocessable_entity
   end
  end

  def destroy
   return render_not_found if @share.blank?
   return render_not_found(:forbidden) if @share.user != current_user
   @share.destroy
   flash[:notice] = "Your code share was destroyed."
   redirect_to shares_path
  end

  def upvote
   @share.votes.create
   flash[:notice] = "Code Share Upvoted!."
   redirect_to shares_path
  end

  private

  def share_params
    params.require(:share).permit(:body, :title)
  end

  def set_share
    @share = Share.find_by_id(params[:id])
  end

  def require_creator
    access_denied unless user_signed_in? && (current_user == @share.user)
  end

end
