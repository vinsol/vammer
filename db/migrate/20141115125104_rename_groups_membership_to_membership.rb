class RenameGroupsMembershipToMembership < ActiveRecord::Migration
  def change
    rename_table :groups_members, :memberships
  end
end
