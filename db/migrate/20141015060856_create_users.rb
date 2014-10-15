class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :job_title
      t.date :date_of_birth
      t.string :mobile_number
      t.string :about_me
      t.boolean :is_admin
      t.boolean :is_enabled

      t.timestamps
    end
  end
end
