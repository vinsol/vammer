class ChangeAttachmentToAttchable < ActiveRecord::Migration
  def change
    rename_column :attachments, :attachment_type, :attachable_type
    rename_column :attachments, :attachment_id, :attachable_id
  end
end
