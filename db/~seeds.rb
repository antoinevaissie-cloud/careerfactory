# for each of the ~5 recrutiers which email is whose on cal.com so as to embed the widget
# create the webhook on each of the cal.com accounts , webhook should point to “https://www.factory.careers/cal_endpoint”
# to test open the local tunnel ➜  unfuck git:(master) ✗ lt -p 3000 --print-requests
# example {https://cyan-beds-teach-104-133-236-111.loca.lt}/cal_endpoint



CampaignUser.destroy_all
Campaign.destroy_all
User.destroy_all
Company.destroy_all

require 'csv'

companies = ["Wiz","Teradata","Salesforce","Palo Alto Networks","Netapp","Mongodb","Linkedin","Instagram","Gitlab","Elastic","Datadog","Databricks","Collibra","Apple","Aiven","Optimizely","Zoominfo","Quantum Metric","Exabeam","Broadcom","Climate Engine","Trax","Carto","Liveramp","Crux","Zebra","Vimeo","Planet","Sensormatic", "Le Wagon"]
photos = ["wiz.png","teradata.png","salesforce.png","paloaltonetworks.png","netapp.png","mongodb.png","linkedin.png","instagram.png","gitlab.png","elastic.png","datadog.png","databricks.png","collibra.png","apple.png","aiven.png","optimizely.png","zoominfo.png","quantummetric.png","exabeam.png","broadcom.png","climateengine.png","trax.png","carto.png","liveramp.png","crux.png","zebra.png","vimeo.png","planet.png","sensormatic.png","lewagon.png"]

#create companies

companies.each_with_index do |name, index|
  company = Company.create!(name: name)
  photo_path = File.join(Rails.root, "/public/seed/#{photos[index] || 'lol.png'}")
  company.photo.attach(io: File.open(photo_path), filename: 'company photo', content_type: 'image/*') if File.exist?(photo_path)
end

count = 0
CSV.foreach(Rails.root.join('db', 'users.csv'), headers: true) do |row|
  break if count >= 100
  next if row['email'].blank?

  puts "Processing row: #{row.inspect}"
  count += 1
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
    company: Company.all.sample
  )
  user.save!
end


User.where(role: 'recruiter').each_with_index do |recruiter, index|
  photo_num = (index + 1) % 12
  photo_path = File.join(Rails.root, "/public/seed/student#{photo_num + 1}.jpeg")
  recruiter.avatar.attach(io: File.open(photo_path), filename: "recruiter_#{index + 1}.jpeg", content_type: 'image/*')
end

User.where(role: 'student').each_with_index do |student, index|
  puts "Create campaign if it doesnt exist for #{student.first_name} #{student.last_name}"
  campaign = Campaign.find_by(batch_number: student.batch_number)
  campaign = Campaign.create!(batch_number: student.batch_number) if campaign.nil?
  CampaignUser.create(
    campaign: campaign,
    user: student
  )
end

#create batch managers

# 3.times do |n|
#   first_name = first_names.sample
#   last_name = last_names.sample
#   company = Company.find_by(name: "Le Wagon")
#   email = "#{first_name}.#{last_name}@lewagon.com"

#   User.create(
#     email: email,
#     password: "123456",
#     first_name: first_name,
#     last_name: last_name,
#     role: "Manager",
#     company: company
#   )
# end

# User.create(
#   email: "user1@gmail.com",
#   password: "123456",
#   first_name: "super",
#   last_name: "batch_manager",
#   role: "Manager",
#   company: Company.find_by(name: "Le Wagon")
# )

# batch_manager = User.where(role: "Manager").last

# #Create recruiters
# 10.times do |n|
#   first_name = first_names.sample
#   last_name = last_names.sample
#   company = Company.all.sample
#   email = "#{first_name}.#{last_name}@#{company}.com"

#   User.create(
#     email: email,
#     password: "123456",
#     first_name: first_name,
#     last_name: last_name,
#     role: "Recruiter",
#     company: company
#   )


# end

# #create students
# 30.times do |n|
#   first_name = first_names.sample
#   last_name = last_names.sample
#   company = Company.find_by(name: "Le Wagon")
#   email = "#{first_name}.#{last_name}@#{student_email}.com"

#   User.create(
#     email: email,
#     password: "123456",
#     first_name: first_name,
#     last_name: last_name,
#     role: "Student",
#     batch_number: batch_number.sample,
#     company: company
#   )
# end

#create campaigns
# 5.times do |n|
#   current_campaign = Campaign.create(
#     batch_number: batch_number.sample,
#     start_date: "2023-01-01",
#     end_date: "20223-01-02",
#     slot_size: 15,
#     user_id: batch_manager.id
#   )

#   3.times do |n|
#     CampaignUser.create(
#       campaign_id: current_campaign.id,
#       user_id: User.where(role: "recruiter").sample.id
#     )
#   end
# end

# User.find_by(email: 'aabdelaziz@wiz.com').update(cal_link: 'antoine-vaissi--lumxva/')
# User.find_by(email: 'aabdelaziz@wiz.com').update(cal_api_key: 'blabla')
# User.find_by(email: 'aabdelaziz@wiz.com').update(cal_api_key: 'blabla')
# User.find_by(email: 'aabdelaziz@wiz.com').update(cal_api_key: 'blabla')
# User.find_by(email: 'aabdelaziz@wiz.com').update(cal_api_key: 'blabla')
