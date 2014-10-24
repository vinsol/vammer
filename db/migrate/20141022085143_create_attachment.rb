class CreateAttachment < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :attachment_type
      t.integer :attachment_id
    end
  end
end
