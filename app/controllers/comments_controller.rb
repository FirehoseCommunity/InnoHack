class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @share = Share.find_by_id(params[:share_id])
    return render_not_found if @share.blank?
    @share.comments.create(comment_params.merge(user: current_user))
    redirect_to share_path(@share)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
