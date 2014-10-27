require 'securerandom'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  validate :email_matches_company_domain

  before_validation :set_initial_password

  after_create :send_set_password_email

  def set_initial_password
    self.password ? true : self.password = SecureRandom.hex
  end

  def send_set_password_email
    send_reset_password_instructions
  end

  # fix- Rename to #email_matches_company_domain -DONE
  def email_matches_company_domain
    company_data = YAML.load_file('config/config.yml')
    if company_data['company']['domain'] != email.split('@').last
      errors.add(:email, 'domain does not match with companies domain')
    end
  end

end
