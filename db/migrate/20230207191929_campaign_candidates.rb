class CampaignCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_candidates  do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
