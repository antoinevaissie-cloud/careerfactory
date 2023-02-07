class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.integer :batch_number
      t.datetime :start_date
      t.datetime :end_date
      t.integer :slot_size

      t.timestamps
    end
  end
end
