#FIXME_AB: As I said in user model. We can name this model as membership
class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :group
  #FIXME_AB: Why using old validation syntax -DONE
  validates :user_id, uniqueness: { scope: :group_id }
end