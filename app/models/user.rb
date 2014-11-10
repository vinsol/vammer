#FIXME_AB: Indexes missing on almost all tables
class User < ActiveRecord::Base
  
  START_YEAR = 1970
  USER_DETAILS = %i(name about_me job_title email date_of_birth mobile joining_date)

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  accepts_nested_attributes_for :image

  has_one :image, as: :attachment, dependent: :destroy

  has_many :groups_members, dependent: :destroy
  has_many :groups, through: :groups_members
  has_many :owned_groups, class_name: Group, foreign_key: :creator_id
  has_many :posts, dependent: :destroy

  validates :name, presence: :true
  validate :email_matches_company_domain

  def active_for_authentication?
    super && enabled
  end

  def search_extraneous
    groups = self.groups.pluck(:id)
    Group.where.not(id: groups)
  end

  private

    def email_matches_company_domain
      if COMPANY['domain'] != email.split('@').last
        errors.add(:email, 'domain does not match with companies domain')
      end
    end

end
