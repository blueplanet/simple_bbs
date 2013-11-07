module TopicsHelper
  def raw_favorite_link(topic)
    if current_user && current_user.favorite_topics.where(topic: topic).first.present?
      link_to t(".unfavorite"), unfavorite_topic_path(@topic), method: :post
    else
      link_to t(".favorite"), favorite_topic_path(@topic), method: :post
    end
  end
end
