#FIXME_AB: Indexes missing on almost all tables
class User < ActiveRecord::Base
  
  START_YEAR = 1970
  USER_DETAILS = %i(name about_me job_title email date_of_birth mobile joining_date)

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable
  #FIXME_AB: group all associations, validations and callbacks together. Do it in all models
  #FIXME_AB: No association should be defined without dependent option, in any model
  has_one :image, as: :attachment, dependent: :destroy
  accepts_nested_attributes_for :image
  has_many :groups_members, dependent: :destroy
  has_many :groups, through: :groups_members
  #FIX: Rename to :owned_groups -DONE
  has_many :owned_groups, class_name: Group, foreign_key: :creator_id
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validate :email_matches_company_domain
  validates :name, presence: :true

  #FIX: Move constants to top -DONE

  def active_for_authentication?
    super && enabled
  end

  def search_extraneous
    groups = self.groups.pluck(:id)
    Group.where.not(id: groups)
  end


  private


    def email_matches_company_domain
      if COMPANY['domain'] != email.split('@').last
        errors.add(:email, 'domain does not match with companies domain')
      end
    end

    #FIXME_AB: This should be the default column value, so that we don't need to set it when creating.

end
