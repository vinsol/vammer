class AddIndexOnTables < ActiveRecord::Migration
  def change
    add_index :posts, :user_id
    add_index :posts, :group_id
    add_index :groups, :creator_id
  end
end
