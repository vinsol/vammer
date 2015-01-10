class Group < ActiveRecord::Base

  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user
  has_many :posts, dependent: :destroy
  belongs_to :creator, class_name: User

  validates :name, uniqueness: true, format: { with: /\A([a-z]|\s)+\z/i, message: 'only letters' }, length: { maximum: 255 }
  validates :name, :description, presence: true

  after_create :add_creator_to_member

  def self.sort_by_creator(collection, direction)
    collection.joins(:creator).order("users.name #{ direction }")
  end

  def self.sort(collection, column, direction)
    collection.order(column => direction)
  end

  def owner?(current_user)
    creator == current_user
  end

  def self.fetch_groups(term)
    Group.where('name ilike ? ', '%' + term + '%').map { |u| [u, false] }
  end

  private

    def add_creator_to_member
      members.push creator
    end

end