class Reply < ActiveRecord::Base
  belongs_to :topic, counter_cache: true

  validates :body, presence: true
end
