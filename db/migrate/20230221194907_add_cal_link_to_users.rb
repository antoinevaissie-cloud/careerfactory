class AddCalLinkToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :cal_link, :string
  end
end
