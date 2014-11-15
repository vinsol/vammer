module ApplicationHelper

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
    #FIX: This method should not return nil in any case
    current_user.groups.include? group ? link_to :unjoin, unjoin_group_path(group) : link_to :join, join_group_path(group)
      #FIX: This condition can be moved to view
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
