class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :follower
      t.references :followed_user
    end
  end
end
