class NotificationMailer < ApplicationMailer
  default from: "no-reply@innohack.com"

  def comment_added(comment)
    @share = comment.share
    @share_owner = @share.user
    mail(to: @share_owner.email, subject: "A comment has been added to #{@share.title}")
  end

end
