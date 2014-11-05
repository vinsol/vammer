module ApplicationHelper

  def admin_logged_in?
    current_user.admin?
  end

  #FIX: Fix sorting with pagination
  def sort_direction_link(order, direction)
    image = image_tag("#{direction}.png")
    #FIX: Try to make this independent of controller and action names.
    link_to image, controller: params[:controller], action: params[:action], order: order, direction: direction, page: params[:page]
  end

  def link_to_by_order(link)
    #FIX: sort_order is being used only in if part
    sort_order = params[:direction] == 'asc' ? :desc : :asc
    if link.to_s == params[:order]
      sort_direction_link params[:order], sort_order
    else
      sort_by_ascending_image = sort_direction_link link, :asc
      sort_by_descending_image = sort_direction_link link, :desc
      [sort_by_ascending_image, sort_by_descending_image].join().html_safe
    end
  end

  def admin_or_self_user?(user)
    admin_logged_in? or !not_self_user?(user)
  end

  #FIX: user_logged_in?(user)
  def not_self_user?(user)
    current_user != user
  end

  #FIX: Use different view files for each action and extract common code in partials
  def group_action_link(group)

    case params[:action].to_sym
    when :index
    if group.creator != current_user
      joiner_link = link_to :unjoin, unjoin_group_path(group)
    end
    when :owned
    edit_link = link_to :edit, edit_group_path(group)
    when :other
    joiner_link = link_to :join, join_group_path(group)
    end

    if admin_logged_in?
      edit_link = link_to :edit, edit_group_path(group)
    end
    [edit_link, joiner_link].join(' ').html_safe

  end

  def not_owned?
    params[:action] != 'owned'
  end

  #FIX: Rename to #group_join_link
  def group_action(group)
    if current_user.groups.include? group
      link_to :unjoin, unjoin_group_path(group)
    else
      link_to :join, join_group_path(group)
    end

  end

end
