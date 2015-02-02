module PostsHelper

  def linkify_mentions(hashtaggable_content)
    regex = /@([a-z]+)+/i
    hashtagged_content = hashtaggable_content.to_s.gsub(regex) do |content|
      link_to(content, search_mentionable_path(content))
    end
    raw(hashtagged_content)
  end

end
