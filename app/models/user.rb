class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :campaign_users
  has_many :campaigns, ->{order(created_at: :asc)}, through: :campaign_users
  has_many :bookings_as_manager, through: :campaigns, source: :bookings, class_name: 'Booking'
  has_many :bookings_as_candidate, class_name: 'Booking', foreign_key: :candidate_id
  has_many :bookings_as_recruiter, class_name: 'Booking', foreign_key: :recruiter_id
  belongs_to :company, optional: true

  has_one_attached :avatar

  def full_name_and_company
    if company.present?
      "#{first_name} #{last_name} : #{company.name}"
    else
      "#{first_name} #{last_name}"
    end
  end

  def bookings
    if role == 'student'
      bookings_as_candidate
    elsif role == 'recruiter'
      bookings_as_recruiter
    elsif role == 'manager'
      bookings_as_manager
    end
  end

  def batch_campaign
    return nil unless role == 'student'

    Campaign.find_by(batch_number: batch_number)
  end

  def calendar_username
    company&.name&.downcase
  end

  def initials
    if first_name && last_name
      "#{first_name[0]}#{last_name[0]}"
    else
      "AA"
    end
  end

  def initials_color
    color_values = [
      0, # red
      128, # green
      255, # blue
    ]
    if first_name && last_name
      initials_sum = first_name[0].ord + last_name[0].ord
    else
      initials_sum = 3
    end
    color_index = initials_sum % color_values.length
    "rgb(#{color_values[color_index]}, #{color_values[(color_index + 1) % color_values.length]}, #{color_values[(color_index + 2) % color_values.length]})"
  end

end
