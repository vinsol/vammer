class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :group
  validates :user_id, uniqueness: { scope: :group_id }

  #FIX: Add validations for presence of user_id, group_id

end