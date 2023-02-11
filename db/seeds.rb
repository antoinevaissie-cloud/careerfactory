# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Clear the existing data

User.destroy_all

companies = ["google", "amazon", "facebook", "microsoft"]
first_names = ["clay", "burt", "kelly", "mike", "bruce"]
last_names = ["power", "ducourty", "skelly", "everhard", "johnson"]

5.times do |n|
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
