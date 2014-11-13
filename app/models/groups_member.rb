#FIXME_AB: As I said in user model. We can name this model as membership
class GroupsMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  #FIXME_AB: Why using old validation syntax
  validates_uniqueness_of :user_id, scope: :group_id
end