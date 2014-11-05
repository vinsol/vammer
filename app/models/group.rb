class Group < ActiveRecord::Base

  #FIX: Rename to :groups_members
  has_many :groups_members, dependent: :destroy

  #FIX: Rename association to :members
  has_many :members, through: :groups_members, source: :user

  #FIX: Add dependent destroy
  has_many :posts, dependent: :destroy

  #FIX: Use creator_id as foreign_key -DONE
  belongs_to :creator, class_name: User, foreign_key: :creator_id

  validates :name, :description, presence: true

  #FIX: Add a callback to add creator to members of group

  #FIX: Move to User class and use better name
  def self.search_other(current_user)
    groups = current_user.groups.pluck(:id)
    where.not(id: groups)
  end

end