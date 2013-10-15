class Topic < ActiveRecord::Base
  belongs_to :node
  belongs_to :author, class_name: "User"
  has_many :replies, -> { order "created_at DESC"}
end
