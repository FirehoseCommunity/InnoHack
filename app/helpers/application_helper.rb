module ApplicationHelper
  def share_owner?(share)
    current_user == share.user
  end

  def comment_owner?(comment)
    current_user == comment.user
  end
end
