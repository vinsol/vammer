class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_one :attachment, as: :attachment, dependent: :destroy

  accepts_nested_attributes_for :attachment

  validate :email_domain

  #FIX: We do not need this.
  validate :adult?, on: :update

  validates :job_title, :name, format: { with: /\A[a-z]+\z/i, message: 'only letters are allowed' }, on: :update, allow_blank: true

  #FIX: Use format instead of numericality
  validates :mobile, numericality: { only_integer: true }, length: {is: 10}, on: :update, allow_blank: true

  def email_domain
    company_data = YAML.load_file('config/config.yml')
    if company_data['company']['domain'] != email.split('@').last
      errors.add(:email, 'domain does not match with companies domain')
    end
  end

  def set_token
    set_reset_password_token
  end

  def adult?
    if date_of_birth > Time.now - 18.year
      errors.add :date_of_birth, 'must be greater than 18 years'
      false
    end
  end


end
