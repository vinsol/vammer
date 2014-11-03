module ApplicationHelper

  include Configuration

  def company_config
    #FIX: Use directly at places.
    COMPANY
  end

  def admin_logged_in?
    #FIX: Use #admin?
    current_user.admin
  end

  def sort_direction_link(order, direction)
    image = image_tag("#{direction}.png")
    if params[:controller] == 'users'
      link_to image, users_path(order: order, direction: direction)
    else
      link_to image, controller: :groups, action: params[:action], order: order, direction: direction
    end
  end

  def link_to_by_order(link)
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

  def not_self_user?(user)
    current_user != user
  end

  def fetch_logo
    setting = Setting.where(key: :logo).first
    setting ? setting : 'not image'
  end

  def group_action_link(group)

    case params[:action].to_sym
    when :index
    joiner_link = link_to :unjoin, unjoin_group_path(group)
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

end
