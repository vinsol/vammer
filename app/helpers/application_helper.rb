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
    admin_logged_in? || creator_logged_in?(user)
  end

  def creator_logged_in?(user)
    current_user == user
  end

  #FIXME_AB: should be used as group.owner?(current_user). Or use some other permission engine like can can
  #FIX: Move to model
  # def group_owner_logged_in?(group)
  #   group.creator == current_user
  # end

  def group_join_link(group)
    #FIXME_AB: logic can be improved.
    if current_user.groups.include? group
      if group.creator != current_user
        link_to :unjoin, unjoin_group_path(group)
      end
    else
      link_to :join, join_group_path(group)
    end
  end

  #FIX: Will see after moving #like/#unlike to posts, comments controllers
  def post_like_unlike(like, likeable)
    if like.nil?
      link_to 'Like', post_like_path(likeable), method: :post, class: 'like' , remote: :true
    else
      link_to 'Unlike', post_unlike_path(likeable, like), method: :delete, class: 'unlike', remote: :true
    end
  end

  #FIX: Will see after moving #like/#unlike to posts, comments controllers
  def comment_like_unlike(like, likeable)
    if like.nil?
      link_to 'Like', post_comment_like_path(likeable.post, likeable), method: :post, class: 'like comment-margin', remote: :true
    else
      link_to 'Unlike', post_comment_unlike_path(likeable.post, likeable, like), method: :delete, class: 'unlike comment-margin', remote: :true
    end
  end

  #FIX: Will see after moving #like/#unlike to posts, comments controllers
  def link_to_like_unlike(likeable, method)
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
    #FIX: This method should not return nil in any case
    #FIX: This condition can be moved to view

  def missing_image_tag
    image_tag('missing.jpg')
  end

  private

    def sort_direction_link(order, direction)
      image = image_tag("#{direction}.png")
      link_to image, controller: controller_name, action: action_name, order: order, direction: direction, page: params[:page]
    end

end
