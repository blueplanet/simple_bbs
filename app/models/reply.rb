class Reply < ActiveRecord::Base
  belongs_to :topic, counter_cache: true
  belongs_to :author, class_name: "User"

  validates :body, presence: true
end
