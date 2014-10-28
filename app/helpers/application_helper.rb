module ApplicationHelper

  def get_company_name
    YAML.load_file('config/config.yml')['company']['name']
  end

  def get_company_domain
    YAML.load_file('config/config.yml')['company']['domain']
  end

  def admin_logged_in
    current_user.admin
  end

  def sort_direction_link(order, direction)
    image = image_tag("#{direction}.png")
    link_to image, users_path(order: order, direction: direction)
  end

  def link_to_by_order(link)
    sort_order = params[:direction] == 'asc' ? :desc : :asc
    if link.to_s == params[:order]
      sort_direction_link params[:order], sort_order
    #FIX: Will not work for more than 2 sortable columns
    else
      sort_by_ascending_image = sort_direction_link link, :asc
      sort_by_descending_image = sort_direction_link link, :desc
      [sort_by_ascending_image, sort_by_descending_image].join().html_safe
    end
  end

end
