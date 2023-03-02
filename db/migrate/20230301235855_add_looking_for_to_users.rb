class AddLookingForToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :looking_for, :string
  end
end
