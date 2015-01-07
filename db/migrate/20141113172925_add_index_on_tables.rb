class AddIndexOnTables < ActiveRecord::Migration
  def change
    add_index :posts, :user_id
    add_index :posts, :group_id
    add_index :groups, :creator_id
    add_index :comments, :post_id
    add_index :comments, :user_id
    add_index :likes, :user_id
    add_index :groups_members, :user_id
    add_index :groups_members, :group_id
  end
end
