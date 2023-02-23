class CampaignUser < ApplicationRecord
  belongs_to :user
  belongs_to :campaign

  CAL_LINKS = ["email-a/30min", "email-b/30min", "email-c/30min", "email-d/30min", "email-e/30min"]

  after_create do
    user.update(cal_link: CAL_LINKS[campaign.users.count - 1])
    # todo - update user calendar link
    # patch start time end time using the api
  end


end
