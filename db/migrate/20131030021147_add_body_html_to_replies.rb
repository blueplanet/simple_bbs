class AddBodyHtmlToReplies < ActiveRecord::Migration
  include ApplicationHelper

  def change
    add_column :replies, :body_html, :text

    Reply.reset_column_information
    Reply.all.each do |reply|
      reply.body_html = markdown(reply.body)
      reply.save validate: false
    end
  end
end
