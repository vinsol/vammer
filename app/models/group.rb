class Group < ActiveRecord::Base

  #FIX: Rename to :groups_members
  has_many :groups_users

  #FIX: Rename association to :members
  has_many :users, through: :groups_users

  #FIX: Add dependent destroy
  has_many :posts

  #FIX: Use creator_id as foreign_key
  belongs_to :creator, class_name: User, foreign_key: :user_id

  validates :name, :description, presence: true

  #FIX: Add a callback to add creator to members of group

  #FIX: Move to User class and use better name
  def self.search_other(current_user)
    groups = current_user.groups.pluck(:id)
    where.not(id: groups)
  end

end