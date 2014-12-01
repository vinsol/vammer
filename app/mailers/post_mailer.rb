class PostMailer < ActionMailer::Base
  #FIXME_AB: Following line is being repeated in two mailers, can we have something not to repeat
  default from: 'test.vammer@gmail.com'

  def notify_on_like_unlike(current_user, user, post_id)
    @current_user = current_user
    @user = user
    @post_id = post_id
    mail(to: @user.email)
  end

end
