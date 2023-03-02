Booking.destroy_all
CampaignUser.destroy_all
Campaign.destroy_all
User.destroy_all
Company.destroy_all

require 'csv'

companies = ["Aiven", "Apple", "Broadcom", "Carto", "Climate Engine", "Collibra", "Crux", "Databricks", "Datadog", "Elastic", "Exabeam", "Gitlab", "Instagram", "Linkedin", "Liveramp", "Mongodb", "Netapp"]
photos =
["aiven.png",
  "apple.png",
  "broadcom.png",
  "carto.png",
  "climateengine.png",
  "collibra.png",
  "crux.png",
  "databricks.png",
  "datadog.png",
  "elastic.png",
  "exabeam.png",
  "gitlab.png",
  "instagram.png",
  "linkedin.png",
  "liveramp.png",
  "mongodb.png",
  "netapp.png"]

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
    company: Company.find_or_create_by(name: row['company'])

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

User.where(role: 'recruiter').limit(18).each_with_index do |recruiter, index|
recruiter.update(tagline: taglines[index])
end

looking_for =
[
  "We're looking for web developers with expertise in multiple programming languages and frameworks, who can take ownership of complex projects and deliver results on time and on budget. In return, we offer a flexible work environment, competitive compensation, and opportunities for career growth.",
  "Our ideal candidate will have a strong understanding of software development principles and a track record of building scalable web applications. We offer a supportive and collaborative culture, along with the chance to work on cutting-edge projects and technologies.",
  "If you're a web developer with a passion for building visually stunning and user-friendly interfaces, we want to hear from you! We offer a fun and dynamic work environment, along with opportunities for learning and professional development.",
  "Our ideal candidate will have experience with both front-end and back-end development, along with a strong command of web development tools and frameworks. In return, we offer a competitive salary, comprehensive benefits package, and a chance to work on challenging and innovative projects.",
  "We're seeking web developers who are self-motivated and able to work independently, but also thrive in a team-oriented environment. We offer a supportive and inclusive workplace culture, along with opportunities for growth and advancement.",
  "Our ideal candidate will have experience with agile development methodologies and a passion for continuous improvement. We offer a flexible work schedule, opportunities for training and development, and a chance to work on projects that have a positive impact on society.",
  "If you're a web developer who is committed to writing clean, efficient code and staying up-to-date with the latest technologies, we want to talk to you! We offer a collaborative and dynamic work environment, along with competitive compensation and benefits.",
  "We're looking for web developers who are passionate about using technology to solve real-world problems and create meaningful user experiences. In return, we offer a supportive and diverse workplace, along with opportunities for mentorship and growth.",
  "Our ideal candidate will have experience with database design and management, along with knowledge of SQL and other database technologies. We offer a competitive salary, comprehensive benefits, and a chance to work on innovative and challenging projects.",
  "If you're a web developer who is curious and always eager to learn new skills and technologies, we want to hear from you! We offer a fun and collaborative work environment, along with opportunities for career advancement and development.",
  "We're seeking web developers who are team players and have excellent communication and interpersonal skills. We offer a supportive and inclusive workplace culture, along with opportunities for professional development and growth.",
  "Our ideal candidate will have experience with cloud computing platforms and containerization technologies, along with a strong understanding of DevOps principles. In return, we offer a competitive salary, comprehensive benefits package, and opportunities for advancement within the company.",
  "If you're a web developer who is passionate about creating accessible and inclusive web experiences for all users, we want to talk to you! We offer a diverse and inclusive workplace, along with opportunities for learning and growth.",
  "We're looking for web developers who are able to balance technical expertise with strong problem-solving and critical thinking skills. We offer a supportive and collaborative work environment, along with opportunities for mentorship and professional development.",
  "Our ideal candidate will have experience with responsive and mobile-friendly web design, along with knowledge of user experience and user interface design principles. We offer a competitive salary, comprehensive benefits, and a chance to work on innovative and challenging projects.",
  "If you're a web developer who is always experimenting with new technologies and approaches to development, we want to hear from you! We offer a creative and innovative work environment, along with opportunities for learning and growth.",
  "We're seeking web developers who are passionate about building high-performance and scalable web applications. In return, we offer a dynamic and fast-paced work environment, along with opportunities for career growth and advancement.",
  "Our ideal candidate will have experience with agile development methodologies and a strong focus on delivering quality code. We offer a collaborative and inclusive workplace culture, along with competitive compensation and benefits.",
  "If you're a web developer who is interested in working on projects that make a difference in people's lives, we want to talk to you! We offer a supportive and inclusive workplace culture, along with opportunities for professional development and growth.",
  "We're looking for web developers who are passionate about using technology to create innovative solutions to complex problems. In return, we offer a flexible and autonomous work environment, along with opportunities for learning and growth.",
  "Our ideal candidate will have experience with full-stack development, along with a strong understanding of web development principles and technologies. We offer a competitive salary, comprehensive benefits package, and a chance to work on projects with global impact.",
  "If you're a web developer who is driven by a desire to create exceptional user experiences, we want to hear from you! We offer a fun and dynamic work environment, along with opportunities for professional development and growth.",
  "We're seeking web developers who are passionate about building scalable and secure web applications. In return, we offer a collaborative and supportive work environment, along with opportunities for learning and professional development.",
  "Our ideal candidate will have experience with testing frameworks and a commitment to delivering high-quality code. We offer a competitive salary, comprehensive benefits, and a chance to work on challenging and meaningful projects.",
  "If you're a web developer who is excited about the prospect of working on innovative and cutting-edge projects, we want to talk to you! We offer a dynamic and fast-paced work environment, along with opportunities for learning and growth.",
  "We're looking for web developers who are passionate about creating web experiences that are accessible and inclusive for all users. In return, we offer a collaborative and inclusive workplace culture, along with opportunities for professional development and growth.",
  "Our ideal candidate will have experience with front-end frameworks and a strong understanding of web design principles. We offer a competitive salary, comprehensive benefits, and a chance to work on innovative and challenging projects.",
  "If you're a web developer who is interested in working on projects with global impact and making a difference in the world, we want to hear from you! We offer a supportive and dynamic work environment, along with opportunities for learning and professional development.",
  "We're seeking web developers who are passionate about using technology to improve people's lives and make the world a better place. In return, we offer a flexible and autonomous work environment, along with opportunities for growth and advancement.",
  "Our ideal candidate will have experience with continuous integration and deployment, along with a commitment to delivering high-quality code. We offer a competitive salary, comprehensive benefits, and a chance to work on cutting-edge projects and technologies.",
  "If you're a web developer who is committed to building web applications that are both functional and beautiful, we want to talk to you! We offer a collaborative and supportive work environment, along with opportunities for professional development and growth.",
  "We're looking for web developers who are passionate about creating web experiences that are fast, reliable, and scalable. In return, we offer a dynamic and fast-paced work environment, along with opportunities for career growth and advancement.",
  "Our ideal candidate will have experience with JavaScript frameworks and a strong understanding of web development principles. We offer a competitive salary, comprehensive benefits package, and a chance to work on challenging and innovative projects."
]

User.where(role: 'recruiter').limit(18).each_with_index do |recruiter, index|
recruiter.update(looking_for: looking_for[index])
end

skills =
[
  'React, JavaScript, HTML, CSS, Webpack',
  'Angular, TypeScript, RESTful APIs, Sass, Jasmine',
  'Node.js, Express.js, MongoDB, Redis, Socket.io',
  'Vue.js, Vuex, Nuxt.js, Axios, ESLint',
  'Laravel, PHP, MySQL, Composer, PHPUnit',
  'Django, Python, PostgreSQL, Redis, Celery',
  'ASP.NET, C#, SQL Server, Entity Framework, MVC',
  'Ruby on Rails, PostgreSQL, RSpec, Sidekiq, Capistrano',
  'Spring, Java, Hibernate, Maven, JUnit',
  'Scala, Akka, Play Framework, Slick, JUnit',
  'Ruby, RSpec, Sinatra, PostgreSQL, Puma',
  'JavaScript, jQuery, Bootstrap, PHP, MySQL',
  'React Native, Redux, GraphQL, Apollo Client, Expo',
  'Ionic, Angular, Firebase, Cordova, Jasmine',
  'Flutter, Dart, Firebase, Provider, Mockito',
  'Objective-C, Swift, CocoaPods, Alamofire, Core Data',
  'Kotlin, Android, Room, Retrofit, Espresso',
  'Xamarin, C#, Azure, Visual Studio, App Center'
]

User.where(role: 'recruiter').limit(18).each_with_index do |recruiter, index|
recruiter.update(skills: skills[index])
end

company_descriptions = [
  "Aiven is a cloud technology company providing managed open-source data technologies to businesses. Our mission is to enable businesses to drive digital transformation with data.",
  "Apple is a multinational technology company headquartered in Cupertino, California, that designs, develops, and sells consumer electronics, computer software, and online services.",
  "Broadcom is a global infrastructure technology leader that designs, develops, and supplies semiconductor and infrastructure software solutions.",
  "Carto is a cloud-based, location intelligence platform that empowers businesses with the tools they need to discover key insights and make more informed decisions.",
  "Climate Engine provides tools for satellite-based crop mapping, yield prediction, and water use monitoring, delivering cutting-edge technology solutions to the agriculture industry.",
  "Collibra is a cross-organizational data governance platform that enables organizations to easily find, understand, and trust their data.",
  "Crux is a cloud-based platform that offers end-to-end data delivery, data operations, and data analytics to organizations that require the highest level of data security and compliance.",
  "Databricks provides a unified analytics platform that enables businesses to accelerate innovation by unifying data science, engineering, and business on a single, cloud-based platform.",
  "Datadog is a cloud-based monitoring and analytics platform that helps organizations gain insights into their applications, infrastructure, and logs in real-time.",
  "Elastic is a search company that builds self-managed and SaaS offerings that make data usable in real-time and at scale for search, logging, security, and analytics use cases.",
  "Exabeam is a cloud-based cybersecurity platform that helps organizations detect, investigate, and respond to cyber threats in real-time.",
  "GitLab is a web-based Git repository manager that provides continuous integration/continuous delivery (CI/CD) capabilities and a user-friendly interface.",
  "Instagram is a social media platform that allows users to share photos and videos, connect with friends, and follow other users or brands.",
  "LinkedIn is a social networking platform designed specifically for the business community, allowing users to connect with other professionals, find jobs, and share knowledge and insights.",
  "Liveramp is a cloud-based platform that provides solutions for data onboarding, identity resolution, and data connectivity, helping businesses to unlock the full potential of their customer data.",
  "Mongodb is a modern, general-purpose database platform that is built for the cloud and provides the flexibility, scalability, and performance that modern applications require.",
  "Netapp is a hybrid cloud data services company that provides a portfolio of cloud data services, data management software, and storage systems to help organizations manage and protect their data.",
]

Company.all.limit(18).each_with_index do |company, index|
company.update(company_descriptions: company_descriptions[index])
end

student_pitch_lines =
[
  'Building the web, one line of code at a time.',
  'Crafting digital experiences that leave a lasting impression.',
  'Innovative web development solutions for modern businesses.',
  'Code that brings your ideas to life.',
  'Creating elegant and intuitive websites.',
  'Web development that exceeds your expectations.',
  'Transforming complex problems into simple solutions.',
  'Bridging design and technology for seamless experiences.',
  'Empowering businesses with custom web solutions.',
  'Creating stunning websites that drive growth.',
  'Building web experiences that stand the test of time.',
  'Where creativity meets code.',
  'Making the web a better place, one project at a time.',
  'Crafting web experiences with purpose and passion.',
  'Web development that simplifies complexity.',
  'Helping businesses thrive with cutting-edge web solutions.',
  'Turning your ideas into reality, one click at a time.',
  'Delivering custom web solutions that elevate your brand.',
  'Innovative web development for the modern era.',
  'Transforming the way we experience the web.',
  'Where form meets function, and design meets code.',
  'Creating web experiences that engage and delight.',
  'Building web solutions that drive results.',
  'Crafting digital solutions that are both beautiful and functional.',
  'Empowering businesses with custom web development.',
  'Transforming businesses with next-level web solutions.',
  'Making the web a better place, one project at a time.'
]

User.where(role: 'student').limit(20).each_with_index do |student, index|
student.update(tagline: student_pitch_lines[index])
end

User.where(role: 'student', batch_number: 1000).each_with_index do |student, index|
  photo_num = (index + 1) % 20
  photo_path = File.join(Rails.root, "/public/seed/student#{photo_num + 1}.jpeg")
  student.avatar.attach(io: File.open(photo_path), filename: "student_#{index + 1}.jpeg", content_type: 'image/*')
end


User.where(role: 'recruiter').each_with_index do |recruiter, index|
photo_num = (index + 1) % 18
photo_path = File.join(Rails.root, "/public/seed/recruiter#{photo_num + 1}.jpeg")
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


User.find_by(email:"adrienc@paloaltonetworks.com").update(cal_link: "adrien-ceron")
