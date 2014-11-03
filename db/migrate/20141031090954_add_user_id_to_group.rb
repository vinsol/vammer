class AddUserIdToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :user_id, :integer
    add_column :groups, :creator, :integer
  end
end
