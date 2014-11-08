class Group < ActiveRecord::Base

  #FIX: Rename to :groups_members -DONE
  has_many :groups_members, dependent: :destroy
  #FIX: Rename association to :members -DONE
  has_many :members, through: :groups_members, source: :user
  #FIX: Add dependent destroy -DONE
  has_many :posts, dependent: :destroy
  #FIX: Use creator_id as foreign_key -DONE
  belongs_to :creator, class_name: User, foreign_key: :creator_id

  validates :name, :description, presence: true

  after_create :add_creator_to_member

  private

    def add_creator_to_member
      members.push creator
    end

  #FIX: Add a callback to add creator to members of group -DONE

  #FIX: Move to User class and use better name -DONE

end