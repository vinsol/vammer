module ApplicationHelper

  def admin_logged_in?
    current_user.admin?
  end

  def sort_direction_link(order, direction)
    image = image_tag("#{direction}.png")
    link_to image, controller: controller_name, action: action_name, order: order, direction: direction, page: params[:page]
  end

  def link_to_by_order(link)
    if link.to_s == params[:order]
      sort_order = params[:direction] == 'asc' ? :desc : :asc
      sort_direction_link params[:order], sort_order
    else
      sort_by_ascending_image = sort_direction_link link, :asc
      sort_by_descending_image = sort_direction_link link, :desc
      [sort_by_ascending_image, sort_by_descending_image].join().html_safe
    end
  end

  def admin_or_self_user?(user)
    admin_logged_in? or user_logged_in?(user)
  end

  def user_logged_in?(user)
    current_user == user
  end

  def group_owner_logged_in?(group)
    current_user.owned_groups.include? group
  end

  def group_join_link(group)
    if current_user.groups.include? group
      if  group.creator != current_user
        link_to :unjoin, unjoin_group_path(group)
      end
    else
      link_to :join, join_group_path(group)
    end

  end

  def post_like_unlike(like, likeable)
    if like.nil?
      link_to 'like', post_likes_path(likeable, group_id: params[:id]), method: :post, class: :like
    else
      link_to 'unlike', post_like_path(likeable, like, group_id: params[:id]), method: :delete, class: :unlike
    end
  end

  def comment_like_unlike(like, likeable)
    if like.nil?
      link_to 'like', post_comment_likes_path(likeable.post, likeable, group_id: params[:id]), method: :post
    else
      link_to 'unlike', like_path(like, group_id: params[:id]), method: :delete
    end
  end

  def link_to_like_unlike(likeable, method)
    if method == :post
      like = Like.where(user_id: current_user, likeable_id: likeable, likeable_type: 'Post').first
      post_like_unlike(like, likeable)
    else
      like = Like.where(user_id: current_user, likeable_id: likeable, likeable_type: 'Comment').first
      comment_like_unlike(like, likeable)
    end
  end

end
