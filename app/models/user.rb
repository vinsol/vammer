require 'securerandom'

class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_one :attachment, as: :attachment, dependent: :destroy

  accepts_nested_attributes_for :attachment

  validates :name, presence: true, on: :update

  validate :email_matches_company_domain

  validates :job_title, :name, format: { with: /\A[a-z]+(\s[a-z])*\z/i, message: 'only letters are allowed' }, on: :update, allow_blank: true

  #FIX: Use format instead of numericality
  validates :mobile, format: { with: /\A\d+\z/ }, length: {is: 10}, on: :update, allow_blank: true

  START_YEAR = 1970

  before_validation :set_initial_password

  def set_initial_password
    self.password = SecureRandom.hex if self.encrypted_password.empty?
  end

  USER_DETAILS = [:name, :about_me, :job_title, :email, :date_of_birth, :mobile, :joining_date]

  # fix- Rename to #email_matches_company_domain -DONE
  def email_matches_company_domain
    company_data = YAML.load_file('config/config.yml')
    if company_data['company']['domain'] != email.split('@').last
      errors.add(:email, 'domain does not match with companies domain')
    end
  end

  def active_for_authentication?
    super && enabled
  end

  def inactive_message
    'Sorry, this account is not enabled.'
  end

end
