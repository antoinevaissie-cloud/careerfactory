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

  def calendar_username
    company&.name&.downcase
  end

  def initials
    "#{first_name[0]}#{last_name[0]}"
  end

  def initials_color
    color_values = [
      0, # red
      128, # green
      255, # blue
    ]
    initials_sum = first_name[0].ord + last_name[0].ord
    color_index = initials_sum % color_values.length
    "rgb(#{color_values[color_index]}, #{color_values[(color_index + 1) % color_values.length]}, #{color_values[(color_index + 2) % color_values.length]})"
  end

end
