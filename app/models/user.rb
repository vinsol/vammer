#FIXME_AB: Indexes missing on almost all tables
class User < ActiveRecord::Base

  START_YEAR = 1970
  USER_DETAILS = %i(name about_me job_title email date_of_birth mobile joining_date)

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  has_one :image, as: :attachment, dependent: :destroy
  #FIXME_AB: instead of groups_members, i think we should name it as group_memberships
  has_many :groups_members, dependent: :destroy
  has_many :groups, through: :groups_members
  has_many :owned_groups, class_name: Group, foreign_key: :creator_id
  #FIXME_AB: Are you sure we want to destroy all related records when we destroy user?. AFAIR we agreed to delete user if there is no record associated with him, else disable him. Please consult with your PM
  has_many :posts, dependent: :destroy

  accepts_nested_attributes_for :image

  #FIXME_AB: since all string fields are auto truncated after 255 chars, its a good idea to add a validation on length.
  validates :name, presence: :true, format: { with: /\A([a-z]|\s)+\z/i, message: 'only letters' }, length: { maximum: 255 }
  
  validate :email_matches_company_domain

  scope :enabled, -> { where(enabled: true) }

  def active_for_authentication?
    super && enabled
  end

  def search_extraneous
    #FIXME_AB: same can be done with self.group_ids i guess.
    groups = self.group_ids
    Group.where.not(id: groups)
  end

  def self.sort(collection, column, direction)
    collection.order(column => direction)
  end

  def large_thumbnail_url
    image.attachment.url(:large)
  end

  private

    def email_matches_company_domain
      if COMPANY['domain'] != email.split('@').last
        #FIXME_AB: when you show any error, it is always a good idea to have it more verbose. You can display the domain name you are expecting
        errors.add(:email, "domain does not match with #{COMPANY['domain']}")
      end
    end

end
