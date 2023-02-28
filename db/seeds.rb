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

# Update students to have no company
User.where(role: 'student').update_all(company_id: nil)

# Add taglines to the first 29 recruiters
taglines = [
  "Building tech teams that change the world.",
  "We turn coding skills into careers.",
  "Accelerating your journey to success.",
  "Join us and shape the future of tech.",
  "Tech talent for a digital age.",
  "Code the future with us.",
  "Empowering developers to make an impact.",
  "Creating better tech, together.",
  "Building the world's best tech companies.",
  "Innovative minds, innovative solutions.",
  "Join our tech revolution.",
  "Where tech meets talent.",
  "Connecting developers with their dream jobs.",
  "Pushing the boundaries of what's possible.",
  "Coding the world we want to live in.",
  "Where tech talent finds a home.",
  "Your next tech career starts here.",
  "Making tech accessible for everyone.",
  "Join us and unleash your potential.",
  "Coding solutions to tomorrow's challenges.",
  "Your tech journey starts with us.",
  "Transforming tech careers one job at a time.",
"Innovating the world of work, one hire at a time.",
"Discover your potential with us.",
"Your tech career starts now.",
"Innovating the world, one code at a time.",
"Building a better future with tech talent.",
"We help tech talent find their dream jobs.",
"Empowering tech talent to reach their full potential.",
"Join our community of tech innovators.",
"Making tech accessible to everyone, everywhere."
]

User.where(role: 'recruiter').limit(29).each_with_index do |recruiter, index|
recruiter.update(tagline: taglines[index])
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
