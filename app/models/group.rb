class Group < ActiveRecord::Base

  has_many :groups_members, dependent: :destroy
  has_many :members, through: :groups_members, source: :user
  has_many :posts, dependent: :destroy
  #FIXME_AB: No need to specify foreign_key here. it will pick form association name. Since association name is creator, hence it will take creator_id automatically 
  belongs_to :creator, class_name: User, foreign_key: :creator_id

  #FIXME_AB: Can to groups have the same name. 
  #FIXME_AB: Are special chars allowed in group name
  validates :name, :description, presence: true

  after_create :add_creator_to_member

  private

    def add_creator_to_member
      members.push creator
    end

end