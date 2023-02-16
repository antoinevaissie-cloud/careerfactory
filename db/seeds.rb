CampaignUser.destroy_all
Campaign.destroy_all
User.destroy_all

require 'csv'

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
