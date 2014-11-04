class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  has_one :image, as: :attachment

  accepts_nested_attributes_for :image

  has_many :groups_users

  has_many :groups, through: :groups_users

  has_many :created_groups, class_name: Group, foreign_key: :user_id

  has_many :posts

  before_create :set_enabled

  validate :email_matches_company_domain

  START_YEAR = 1970

  USER_DETAILS = %i(name about_me job_title email date_of_birth mobile joining_date)

  COMPANY_CONFIGURATIONS_PATH = 'config/config.yml'

  def active_for_authentication?
    enabled
  end

  def inactive_message
    :inactive
  end

  private

    def email_matches_company_domain
      company_data = YAML.load_file(COMPANY_CONFIGURATIONS_PATH)
      if company_data['company']['domain'] != email.split('@').last
        errors.add(:email, 'domain does not match with companies domain')
      end
    end

    def set_enabled
      self.enabled = true
    end

end
