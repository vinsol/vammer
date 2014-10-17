class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :email_in_company_domain

  def email_in_company_domain
    company_data = YAML.load_file('config/config.yml')
    if company_data['company']['domain'] != email.split('@').last
      errors.add(:email, 'domain does not match with companies domain')
    end
  end

end
