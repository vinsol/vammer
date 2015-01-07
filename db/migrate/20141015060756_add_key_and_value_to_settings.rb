class AddKeyAndValueToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :key, :string
    add_column :settings, :value, :string
  end
end
