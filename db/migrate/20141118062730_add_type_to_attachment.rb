class AddTypeToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :type, :string
  end
end
