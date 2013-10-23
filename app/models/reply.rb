class Reply < ActiveRecord::Base
  belongs_to :topic, counter_cache: true
  belongs_to :author, class_name: "User"

  validates :body, presence: true

  after_create :update_topic_last_reply

  private
	  def update_topic_last_reply
	  	self.topic.last_reply = self
	  	self.topic.save
	  end
end
