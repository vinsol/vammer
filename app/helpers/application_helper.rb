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

  #FIXME_AB: I think this can be named better
  def admin_or_self_user?(user)
    #FIXME_AB: why using or. Prefer using ||
    admin_logged_in? or user_logged_in?(user)
  end

  #FIXME_AB: Can be named better
  def user_logged_in?(user)
    current_user == user
  end

  #FIXME_AB: should be used as group.owner?(current_user). Or use some other permission engine like can can
  def group_owner_logged_in?(group)
    current_user.owned_groups.include? group
  end

  def group_join_link(group)
    #FIXME_AB: logic can be improved.
    if current_user.groups.include? group
      if  group.creator != current_user
        link_to :unjoin, unjoin_group_path(group)
      end
    else
      link_to :join, join_group_path(group)
    end

  end

end
