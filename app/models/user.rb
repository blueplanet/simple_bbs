class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics, -> { order "created_at DESC" }, foreign_key: "author_id"
  has_many :replies, -> { order "created_at DESC" }, foreign_key: "author_id"

  def favorite(topic)
    
  end
end
