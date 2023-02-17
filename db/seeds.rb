CampaignUser.destroy_all
Campaign.destroy_all
User.destroy_all

require 'csv'
=begin
CSV.foreach(Rails.root.join('db', 'users.csv'), headers: true) do |row|
  next if row['email'].blank?
  puts "Processing row: #{row.inspect}"

  user = User.new(
    email: row['email'],
    password: row['password'],
    reset_password_token: row['reset_password_token'],
    reset_password_sent_at: row['reset_password_sent_at'],
    remember_created_at: row['remember_created_at'],
    created_at: row['created_at'],
    updated_at: row['updated_at'],
    first_name: row['first_name'],
    last_name: row['last_name'],
    role: row['role'],
    batch_number: row['batch_number'],
    company: row['company']
  )
  user.save!
end
=end


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
    password: "123456",
    first_name: first_name,
    last_name: last_name,
    role: "Manager",
    company: company
  )


end

User.create(
  email: "user1@gmail.com",
  password: "123456",
  first_name: "super",
  last_name: "batch_manager",
  role: "Manager",
  company: "leWagon"
)

batch_manager = User.where(role: "Manager").last

#Create recruiters
10.times do |n|
  first_name = first_names.sample
  last_name = last_names.sample
  company = companies.sample
  email = "#{first_name}.#{last_name}@#{company}.com"

  User.create(
    email: email,
    password: "123456",
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
    password: "123456",
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
