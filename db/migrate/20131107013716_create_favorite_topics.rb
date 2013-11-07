class CreateFavoriteTopics < ActiveRecord::Migration
  def change
    drop_table :topics_users

    create_table :favorite_topics do |t|
      t.references :user, index: true
      t.references :topic, index: true

      t.timestamps
    end
  end
end
