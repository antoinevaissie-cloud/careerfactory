class AddCalApiKeyToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cal_api_key, :string
  end
end
