class AddSkillsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :skills, :string
  end
end
