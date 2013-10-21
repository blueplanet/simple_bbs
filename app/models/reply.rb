class Reply < ActiveRecord::Base
  belongs_to :topic, counter_cache: true
  belongs_to :anthor, class_name: "User"

  validates :body, presence: true
end
