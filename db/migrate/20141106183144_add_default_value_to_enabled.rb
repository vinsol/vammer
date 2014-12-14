class AddDefaultValueToEnabled < ActiveRecord::Migration
  def change
    change_column :users, :enabled, :boolean, default: true
  end
end
