module ApplicationHelper

  def admin_logged_in?
    current_user.admin?
  end

  #FIX: Fix sorting with pagination -DONE
  def sort_direction_link(order, direction)
    image = image_tag("#{direction}.png")
    #FIX: Try to make this independent of controller and action names.
    link_to image, controller: params[:controller], action: params[:action], order: order, direction: direction, page: params[:page]
  end

  def link_to_by_order(link)
    #FIX: sort_order is being used only in if part -DONE
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

  #FIX: user_logged_in?(user) -DONE
  def user_logged_in?(user)
    current_user == user
  end

  def group_owner_logged_in?(group)
    current_user.created_groups.include? group
  end

  #FIX: Use different view files for each action and extract common code in partials

  # FIX: Rename to #group_join_link -DONE
  def group_join_link(group)
    if current_user.groups.include? group
      if  group.creator != current_user
        link_to :unjoin, unjoin_group_path(group)
      end
    else
      link_to :join, join_group_path(group)
    end

  end

end
