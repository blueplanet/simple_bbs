class CreateTopicsUsers < ActiveRecord::Migration
  def change
    create_table :topics_users, id: false do |t|
      t.references :user, index: true
      t.references :topic, index: true
    end
  end
end
