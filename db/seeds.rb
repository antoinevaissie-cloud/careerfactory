# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Clear the existing data

CampaignUser.destroy_all
Campaign.destroy_all
User.destroy_all

student_email = ["lewagon"]
companies = ["google", "amazon", "facebook", "microsoft"]
first_names = ["clay", "burt", "kelly", "mike", "bruce", "leon"]
last_names = ["power", "ducourty", "skelly", "everhard", "johnson", "durand"]

batch_number = [1001,1002,1003]
#create batch managers

3.times do |n|
  first_name = first_names.sample
  last_name = last_names.sample
  company = "Le Wagon"
  email = "#{first_name}.#{last_name}@lewagon.com"

  User.create(
    email: email,
    password: "password",
    first_name: first_name,
    last_name: last_name,
    role: "Manager",
    company: company
  )


end

batch_manager = User.where(role: "Manager").last

#Create recruiters
10.times do |n|
  first_name = first_names.sample
  last_name = last_names.sample
  company = companies.sample
  email = "#{first_name}.#{last_name}@#{company}.com"

  User.create(
    email: email,
    password: "password",
    first_name: first_name,
    last_name: last_name,
    role: "Recruiter",
    company: company
  )


end

#create students
30.times do |n|
  first_name = first_names.sample
  last_name = last_names.sample
  company = student_email.sample
  email = "#{first_name}.#{last_name}@#{student_email}.com"

  User.create(
    email: email,
    password: "password",
    first_name: first_name,
    last_name: last_name,
    role: "Student",
    batch_number: batch_number.sample
  )
end

#create campaigns
5.times do |n|

  current_campaign = Campaign.create(
    batch_number: batch_number.sample,
    start_date: "2023-01-01",
    end_date: "20223-01-02",
    slot_size: 15,
    user_id: batch_manager.id
  )

  3.times do |n|
    CampaignUser.create(
      campaign_id: current_campaign.id,
      user_id: User.where(role: "Recruiter").sample.id
    )
  end
end
