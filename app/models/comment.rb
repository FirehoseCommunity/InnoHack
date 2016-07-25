class Comment < ActiveRecord::Base

  belongs_to :user, foreign_key: 'user_id', class_name: "User"
  belongs_to :share, foreign_key: 'share_id', class_name: "Share"
  after_create :send_comment_email

  def send_comment_email
      NotificationMailer.comment_added(self).deliver_now
  end

end
