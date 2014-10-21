class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  validate :email_matches_company_domain

  # fix- Rename to #email_matches_company_domain -DONE
  def email_matches_company_domain
    company_data = YAML.load_file('config/config.yml')
    if company_data['company']['domain'] != email.split('@').last
      errors.add(:email, 'domain does not match with companies domain')
    end
  end

  # fix- Should not be required after removing :confirmable -DONE

  def set_token
    set_reset_password_token
  end

end
