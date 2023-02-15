class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :campaigns, through: :campaign_users

  def full_name_and_company
    "#{first_name} #{last_name} : #{company}"
  end

end
