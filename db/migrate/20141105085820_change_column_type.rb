class ChangeColumnType < ActiveRecord::Migration
  def change
    change_column :groups, :description, :text
    change_column :posts, :content, :text
  end
end
