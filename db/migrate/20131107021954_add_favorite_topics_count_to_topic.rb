class AddFavoriteTopicsCountToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :favorite_topics_count, :integer, default: 0
  end
end
