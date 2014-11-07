class RenameSettingsColumns < ActiveRecord::Migration
  def change
    remove_column :settings, :key, :string
    remove_column :settings, :value, :string
  end
end
