module PostsHelper

  def linkify_mentions(hashtaggable_content)
    regex = /@([a-z]+)+/i
    hashtagged_content = hashtaggable_content.to_s.gsub(regex) do |content|
      link_to(content, mentioned_path(content))
    end
    hashtagged_content.html_safe
  end

end
