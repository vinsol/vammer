class AddJoiningDateToUser < ActiveRecord::Migration
  def change
    add_column :users, :joining_date, :datetime, default: Time.current
  end
end
