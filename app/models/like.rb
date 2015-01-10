class Like < ActiveRecord::Base

  belongs_to :user
  belongs_to :likeable, polymorphic: true

  #FIX: Use new syntax DONE
  validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type] }
  validates :user_id, :likeable_id, :likeable_type, presence: true

  after_create :send_mail

  def send_mail
    if likeable.try(:post)
      CommentMailer.notify_on_like(user, likeable.user, likeable.post.id).deliver
    else
      CommentMailer.notify_on_like(user, likeable.user, likeable.id).deliver
    end
  end

  #FIX: Add validations for user_id, likeable_id, likeable_type DONE

end