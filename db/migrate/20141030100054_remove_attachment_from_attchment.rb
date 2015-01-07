class RemoveAttachmentFromAttchment < ActiveRecord::Migration
  def change
    remove_column :attachments, :attachment, :string
  end
end
