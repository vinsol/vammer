module PostsHelper

  def linkify_mentions(hashtaggable_content)
    regex = /@([a-z]+)+/i
    hashtagged_content = hashtaggable_content.to_s.gsub(regex) do |a|
      link_to(a, mentioned_path(a))
    end
    hashtagged_content.html_safe
  end

end
