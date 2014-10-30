require 'securerandom'

class User < ActiveRecord::Base
  
  include Configuration

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_one :attachment, as: :attachment, dependent: :destroy

  accepts_nested_attributes_for :attachment

  before_validation :set_initial_password

  validates :name, presence: true, on: :update

  validate :email_matches_company_domain

  START_YEAR = 1970

  USER_DETAILS = %i(name about_me job_title email date_of_birth mobile joining_date)

  def active_for_authentication?
    super && enabled
  end

  def inactive_message
    'Sorry, this account is not enabled.'
  end

  private

    def set_initial_password
      self.password = SecureRandom.hex if self.encrypted_password.empty?
    end

    def email_matches_company_domain
      #FIXME_AB: do not load yml again and again. read that data when rails boots. Put this in initializers
      #FIXME_AB: this conditions should be extracted in a private method.
      if COMPANY['domain'] != email.split('@').last
        errors.add(:email, 'domain does not match with companies domain')
      end
    end

end
