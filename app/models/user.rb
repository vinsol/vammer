class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_one :attachment, as: :attachment, dependent: :destroy

  accepts_nested_attributes_for :attachment

  validate :email_domain

  validates :job_title, :name, format: { with: /\A[a-z]+\z/i, message: 'only letters are allowed' }, on: :update, allow_blank: true

  validates :mobile, format: { with: /\A\d+\z/, message: 'only digits are allowed' }, on: :update, allow_blank: true

  def email_domain
    company_data = YAML.load_file('config/config.yml')
    if company_data['company']['domain'] != email.split('@').last
      errors.add(:email, 'domain does not match with companies domain')
    end
  end

  def set_token
    set_reset_password_token
  end

end
