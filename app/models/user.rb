class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :campaigns, through: :campaign_users
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
    end
  end

  def batch_campaign
    return nil unless role == 'student'

    Campaign.find_by(batch_number: batch_number)
  end

  def calendar_username
    company&.name&.downcase
  end


end
