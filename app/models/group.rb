class Group < ActiveRecord::Base

  has_many :groups_members, dependent: :destroy
  has_many :members, through: :groups_members, source: :user
  has_many :posts, dependent: :destroy
  belongs_to :creator, class_name: User, foreign_key: :creator_id

  validates :name, :description, presence: true

  after_create :add_creator_to_member

  private

    def add_creator_to_member
      members.push creator
    end

end