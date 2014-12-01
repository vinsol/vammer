#FIXME_AB: By default admin field should be false, through migration
class User < ActiveRecord::Base

  #FIX: Move constants to helpers
  START_YEAR = 1970
  USER_DETAILS = %i(name about_me job_title email date_of_birth mobile joining_date)

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  has_one :image, as: :attachable, dependent: :destroy
  has_many :likes
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :owned_groups, class_name: Group, foreign_key: :creator_id
  #FIXME_AB: Are you sure we want to destroy all related records when we destroy user?. AFAIR we agreed to delete user if there is no record associated with him, else disable him. Please consult with your PM
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :follows, class_name: Follow, foreign_key: :follower_id
  has_many :followings, class_name: Follow, foreign_key: :followed_user_id
  #FIXME_AB: I guess there is some confusion with followers and followings. Ideally 'followers' are users who is following me and 'followings' are people who I follow.
  has_many :followers, through: :follows, source: :followed_user
  has_many :followed_users, through: :followings, source: :follower

  accepts_nested_attributes_for :image

  #FIXME_AB: such type of regexp in validations should be extracted out as a constant hash of regexp so that they can be resuxed
  validates :name, presence: :true, uniqueness: :true, format: { with: /\A([a-z]|\s)+\z/i, message: 'only letters' }, length: { maximum: 255 }
  
  validate :email_matches_company_domain

  scope :enabled, -> { where(enabled: true) }

  def active_for_authentication?
    super && enabled
  end

  def search_extraneous
    Group.where.not(id: self.group_ids)
  end

  #FIX: We don't need this
  def self.sort(collection, column, direction)
    collection.order(column => direction)
  end

  def large_thumbnail_url
    image.attachment.url(:large)
  end

  def following?(user)
    followed_users.include? user
  end

  #FIX: Not required
  def number_of_followers
    followers.count
  end

  private

    def email_matches_company_domain
      if COMPANY['domain'] != email.split('@').last
        errors.add(:email, "domain does not match with #{COMPANY['domain']}")
      end
    end

end
