class ChangeAnthorToAuthorOfReplies < ActiveRecord::Migration
  def change
    rename_column :replies, :anthor_id, :author_id
  end
end
