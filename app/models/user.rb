class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :campaigns, through: :campaign_users
  belongs_to :company, optional: true

  def full_name_and_company
    if company.present?
      "#{first_name} #{last_name} : #{company.name}"
    else
      "#{first_name} #{last_name}"
    end
  end


end
