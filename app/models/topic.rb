class Topic < ActiveRecord::Base
  belongs_to :node
  belongs_to :author, class_name: "User"
  has_many :replies, -> { order "created_at DESC"}

  validates :node_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
end
