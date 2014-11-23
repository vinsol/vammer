class Follow < ActiveRecord::Base

  belongs_to :follower, class_name: 'User', inverse_of: :followed_users
  belongs_to :followed_user, class_name: 'User', inverse_of: :followers
  # before_create :add_following

  # def add_following
  #   debugger
  # end

end