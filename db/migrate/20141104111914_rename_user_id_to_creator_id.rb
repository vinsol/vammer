class RenameUserIdToCreatorId < ActiveRecord::Migration
  def change
    rename_column :groups, :user_id, :creator_id
  end
end
