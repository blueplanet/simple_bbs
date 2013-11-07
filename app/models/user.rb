class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics, -> { order "created_at DESC" }, foreign_key: "author_id"
  has_many :replies, -> { order "created_at DESC" }, foreign_key: "author_id"
  has_many :favorite_topics, -> { order "created_at DESC" }
  has_many :favorites, through: :favorite_topics, source: :topic

  def favorite(topic)
    favorite_topics.create topic: topic
  end

  def unfavorite(topic)
    favorite_topics.where(topic: topic).first.try(:destroy)
  end
end
