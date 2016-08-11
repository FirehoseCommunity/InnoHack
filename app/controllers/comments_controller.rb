class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_share, only: [:create, :edit, :update]
  before_action :require_creator, only: [:edit, :update, :destroy]

  def create
    return render_not_found if @share.blank?
    @share.comments.create(comment_params.merge(user: current_user))
    redirect_to share_path(@share)
  end

  def edit
    return render_not_found if @comment.blank?
    return render_not_found(:forbidden) if @comment.user != current_user
  end

  def update
    return render_not_found if @comment.blank?
    return render_not_found(:forbidden) if @comment.user != current_user

    @comment.update_attributes(comment_params)
    if @comment.valid?
     flash[:notice] = "Your comment was updated."
     redirect_to share_path(@share)
    else
     return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return render_not_found if @comment.blank?
    return render_not_found(:forbidden) if @comment.user != current_user
    @comment.destroy
    flash[:notice] = "Your comment was deleted."
    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_comment
      @comment = Comment.find_by_id(params[:id])
    end

    def set_share
      @share = Share.find_by_id(params[:share_id])
    end

    def require_creator
      access_denied unless user_signed_in? && (current_user == @comment.user)
    end

end
