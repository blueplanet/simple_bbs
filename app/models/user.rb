class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics, -> { order "created_at DESC" }, foreign_key: "author_id"
  has_many :replies, -> { order "created_at DESC" }, foreign_key: "author_id"
  has_and_belongs_to_many :favorites, -> { order "created_at DESC"}, class_name: "Topic"

  def favorite(topic)
    favorites << topic
  end

  def unfavorite(topic)
    favorites.delete topic
  end
end
