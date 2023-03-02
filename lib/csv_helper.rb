require 'csv'

def generate_batch_csv_data
  csv_data = CSV.generate do |csv|
    csv << ['Email', 'Password', 'First Name', 'Last Name', 'Role', 'Batch Number', 'Company']
    User.where(role: 'student').select(:batch_number).distinct.each do |batch|
      user = User.where(role: 'student', batch_number: batch.batch_number).first
      csv << [user.email, user.password, user.first_name, user.last_name, user.role, user.batch_number, user.company]
    end
  end

  return csv_data
end
