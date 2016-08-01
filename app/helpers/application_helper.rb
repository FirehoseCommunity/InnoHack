module ApplicationHelper
  def share_owner?(share)
    current_user == share.user
  end
end
