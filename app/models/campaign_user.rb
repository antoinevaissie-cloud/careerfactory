class CampaignUser < ApplicationRecord
  belongs_to :user
  belongs_to :campaign

  CAL_LINKS = ["email-a", "email-b", "email-c", "email-d", "email-e"]

  after_create do
    user.update(cal_link: CAL_LINKS[campaign.users.count - 1])
    # todo - update user calendar link
    # patch start time end time using the api
  end


end
