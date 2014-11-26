class Group < ActiveRecord::Base

  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user
  has_many :posts, dependent: :destroy
  belongs_to :creator, class_name: User

  validates :name, uniqueness: true, format: { with: /\A([a-z]|\s)+\z/i, message: 'only letters' }, length: { maximum: 255 }
  validates :name, :description, presence: true

  #FIX: Rename #add_creator_as_member
  after_create :add_creator_to_member

  #FIX: This should be a scope
  def self.sort_by_creator(collection, direction)
    collection.joins(:creator).order("users.name #{ direction }")
  end

  #FIX: We don't need a method for this
  def self.sort(collection, column, direction)
    collection.order(column => direction)
  end

  #FIX: Rename current_user to user
  def owner?(current_user)
    creator == current_user
  end

  private

    def add_creator_to_member
      members.push creator
    end

end