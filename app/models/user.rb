class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable

  validate :email_domain
  validates :name, presence: true, on: :update

  def email_domain
    company_data = YAML.load_file('config/config.yml')
    if company_data['company']['domain'] != email.split('@').last
      errors.add(:email, 'domain does not match with companies domain')
    end
  end

  # fix- Why do we have this? Please add some documentation for this.
  def password_required?
    super if confirmed?
  end

  def set_token
    set_reset_password_token
  end

end
