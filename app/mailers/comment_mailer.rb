class CommentMailer < ActionMailer::Base
  default from: 'test.vammer@gmail.com'

  def notify_on_create(current_user, user, post_id)
    @current_user = current_user
    @user = user
    @post_id = post_id
    mail(to: @user.email, subject: 'Notification')
  end

  def notify_on_like_unlike(current_user, user, post_id)
    @current_user = current_user
    @user = user
    @post_id = post_id
    mail(to: @user.email, subject: 'Notification')
  end

end
