class Reply < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :topic, counter_cache: true
  belongs_to :author, class_name: "User"

  validates :body, presence: true

  before_save :set_body_html
  after_create :update_topic_last_reply, :update_topic_hot

  private
	  def update_topic_last_reply
	  	self.topic.last_reply = self
	  	self.topic.save
	  end

    def update_topic_hot
      self.topic.node.hot += 1
      self.topic.node.save
    end

    def set_body_html
      self.body_html = markdown(self.body)
    end
end
