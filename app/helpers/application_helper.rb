module ApplicationHelper

  ALPHABETS = 'A'..'Z'

  def admin_logged_in?
    current_user.admin?
  end

  def link_to_order(link)
    if link.to_s == params[:order]
      sort_order = params[:direction] == 'asc' ? :desc : :asc
      sort_direction_link params[:order], sort_order
    else
      sort_by_ascending_image = sort_direction_link link, :asc
      sort_by_descending_image = sort_direction_link link, :desc
      [sort_by_ascending_image, sort_by_descending_image].join().html_safe
    end
  end

  def can_edit_user?(user)
    #FIXME_AB: can we use cancan or pundit for such authorization?
    admin_logged_in? || creator_logged_in?(user)
  end

  #FIXME_AB: Is the method name is appropriate? this method has nothing to do with creator
  def creator_logged_in?(user)
    current_user == user
  end

  def post_like_unlike(like, likeable)
    if like.nil?
      link_to 'Like', post_like_path(likeable), method: :post, class: 'like' , remote: :true
    else
      link_to 'Unlike', post_unlike_path(likeable, like), method: :delete, class: 'unlike', remote: :true
    end
  end

  def comment_like_unlike(like, likeable)
    if like.nil?
      link_to 'Like', post_comment_like_path(likeable.post, likeable), method: :post, class: 'like comment-margin', remote: :true
    else
      link_to 'Unlike', post_comment_unlike_path(likeable.post, likeable, like), method: :delete, class: 'unlike comment-margin', remote: :true
    end
  end

  def link_to_like_unlike(likeable, method)
    #FIXME_AB: You have associations available so use current_user.likes.where 
    if method == :post
      like = Like.where(user_id: current_user, likeable_id: likeable, likeable_type: 'Post').first
      post_like_unlike(like, likeable)
    else
      like = Like.where(user_id: current_user, likeable_id: likeable, likeable_type: 'Comment').first
      comment_like_unlike(like, likeable)
    end
  end

  def link_to_join_unjoin
    current_user.groups.include?(group) ? link_to(:unjoin, unjoin_group_path(group)) : link_to(:join, join_group_path(group))
  end

  def missing_image_tag
    image_tag('missing.jpg')
  end

  private

    def sort_direction_link(order, direction)
      image = image_tag("#{direction}.png")
      link_to image, controller: controller_name, action: action_name, order: order, direction: direction, page: params[:page]
    end

end
