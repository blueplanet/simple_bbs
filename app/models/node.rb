class Node < ActiveRecord::Base
  has_many :topics, -> { order "replies_count DESC" }

  scope :hot, -> { order "hot DESC"}
end
