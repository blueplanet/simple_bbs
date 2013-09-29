class Topic < ActiveRecord::Base
  belongs_to :node
  has_many :replies, -> { order "created_at DESC"}
end
