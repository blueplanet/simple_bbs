class Topic < ActiveRecord::Base
  include ApplicationHelper
  
  belongs_to :node
  belongs_to :author, class_name: "User"
  has_many :replies, -> { order :created_at }
  belongs_to :last_reply, class_name: "Reply"

  validates :node_id, presence: true
  validates :title, presence: true
  validates :body, presence: true

  before_save :update_body_html
  after_create :update_node_hot

  private
    def update_node_hot
      self.node.hot += 1
      self.node.save
    end

    def update_body_html
      self.body_html = markdown(self.body)
    end
end
