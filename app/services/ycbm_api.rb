require 'rest-client'
require 'json'

class YcbmApi



  def retrieve_bookings
    RestClient::Request.execute(
      method: :get,
      url: "https://api.youcanbook.me/v1/#{ENV['YOUCANBOOKME_ACCOUNT']}/bookings",
      user: ENV["YOUCANBOOKME_ACCOUNT"],
      password: ENV["YOUCANBOOKME_API_KEY"]
      #payload: { key1: 'value1', key2: 'value2' }
    )
  end
end
