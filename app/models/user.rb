#FIXME_AB: Indexes missing on almost all tables
class User < ActiveRecord::Base
  
  include Configuration

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable
  #FIXME_AB: group all associations, validations and callbacks together. Do it in all models
  #FIXME_AB: No association should be defined without dependent option, in any model
  has_one :image, as: :attachment

  accepts_nested_attributes_for :image

  has_many :groups_users

  has_many :groups, through: :groups_users

  #FIX: Rename to :owned_groups
  has_many :created_groups, class_name: Group, foreign_key: :user_id

  has_many :posts

  before_create :set_enabled

  validate :email_matches_company_domain

  validates :name, presence: :true

  #FIX: Move constants to top
  START_YEAR = 1970

  USER_DETAILS = %i(name about_me job_title email date_of_birth mobile joining_date)

  private

    def active_for_authentication?
      super && enabled
    end

    def email_matches_company_domain
      if COMPANY['domain'] != email.split('@').last
        errors.add(:email, 'domain does not match with companies domain')
      end
    end

    def set_enabled
      #FIXME_AB: This should be the default column value, so that we don't need to set it when creating.
      self.enabled = true
    end

end
