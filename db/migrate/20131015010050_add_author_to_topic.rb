class AddAuthorToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :author_id, :integer
  end
end
