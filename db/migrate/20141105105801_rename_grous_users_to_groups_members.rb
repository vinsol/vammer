class RenameGrousUsersToGroupsMembers < ActiveRecord::Migration
  def change
    rename_table :groups_users, :groups_members
  end
end
