class AddAnthorIdToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :anthor_id, :integer
  end
end
