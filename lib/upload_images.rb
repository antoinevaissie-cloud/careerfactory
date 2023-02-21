require 'cloudinary'

Cloudinary.config do |config|
  config.cloud_name = ENV['CLOUDINARY_CLOUD_NAME']
  config.api_key = ENV['CLOUDINARY_API_KEY']
  config.api_secret = ENV['CLOUDINARY_API_SECRET']
end

Dir.glob('/Users/macbook/Documents/screenshots/*.{jpg,jpeg,png,gif}').each do |file_path|
  file_name = File.basename(file_path, '.*')
  Cloudinary::Uploader.upload(file_path, :public_id => file_name, :folder => 'my_app_folder')
end
