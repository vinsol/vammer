class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  has_one :attachment, as: :attachment, dependent: :destroy

  accepts_nested_attributes_for :attachment

  before_create :set_enabled

  validate :email_matches_company_domain

  validates :name, presence: :true

  START_YEAR = 1970

  USER_DETAILS = %i(name about_me job_title email date_of_birth mobile joining_date)

  COMPANY_CONFIGURATIONS_PATH = 'config/config.yml'

  def active_for_authentication?
    super && enabled
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
