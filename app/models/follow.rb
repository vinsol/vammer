class Follow < ActiveRecord::Base

  belongs_to :follower, class_name: 'User', inverse_of: :followed_users
  belongs_to :followed_user, class_name: 'User', inverse_of: :followers
  validates :follower_id, uniqueness: { scope: :followed_user_id }
  validate :can_not_follow_self

  def can_not_follow_self
    if follower_id == followed_user_id
      errors.add :base, 'Can not follow self user'
    end
  end

end