class AddBodyHtmlToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :body_html, :text

    Topic.reset_column_information
    Topic.all.each do |topic|
      topic.body_html = topic.body
    end
  end
end
