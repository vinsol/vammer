class Group < ActiveRecord::Base


  has_many :groups_users

  has_many :users, through: :groups_users

  belongs_to :creator, class_name: User, foreign_key: :user_id

  validates :name, :description, presence: true

  def self.search_other(current_user)
    groups = current_user.groups.pluck(:id)
    where("id not in (?)", groups)
  end

end