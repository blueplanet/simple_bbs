class AddLastReplyIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :last_reply_id, :integer
    Topic.reset_column_information

    Topic.all.each do |topic|
    	if topic.replies.count > 0
	    	topic.last_reply = topic.replies.last
	    	topic.save! validate: false

	    	p topic
	    end
    end
  end
end
