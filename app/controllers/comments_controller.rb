class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @share = Share.find(params[:share_id])
    @share.comments.create(comment_params.merge(user: current_user))
    redirect_to share_path(@share)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
