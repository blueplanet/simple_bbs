module ApplicationHelper
  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, fenced_code_blocks: true)
    markdown.render(text).html_safe
  end
end
