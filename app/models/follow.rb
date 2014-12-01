#FIXME_AB: indexes missing
class Follow < ActiveRecord::Base

  #FIX: Rename :followed_users to :followee
  belongs_to :follower, class_name: 'User', inverse_of: :followed_users
  belongs_to :followed_user, class_name: 'User', inverse_of: :followers

  #FIX: Presence validations
  validates :follower_id, uniqueness: { scope: :followed_user_id }

  #FIX: Try to do it with validates :exclusion
  validate :can_not_follow_self

  def can_not_follow_self
    if follower_id == followed_user_id
      errors.add :base, 'Can not follow self user'
    end
  end

end