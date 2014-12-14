class CreatePost < ActiveRecord::Migration
  def change
    create_table :posts do |t|

      t.belongs_to :group
      t.belongs_to :user
      t.string :content
      t.timestamps
    end
  end
end
