class Topic < ActiveRecord::Base
  belongs_to :node
  belongs_to :author, class: User
  has_many :replies, -> { order "created_at DESC"}
end
