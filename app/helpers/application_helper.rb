module ApplicationHelper

  #FIX: Rename. Use just #company_config.
  def company_config
    YAML.load_file('config/config.yml')['company']
  end

  def admin_logged_in
    current_user.admin
  end

  #FIX: When user visits the index page for first time, each field should have links to sort in asc/desc order.
  #FIX: When the list is sorted on a field, that field should have the link to order in opposite direction and other fields should have both links.
  #FIX: Use something else instead of variable names 'link' and 'order'. Something more clear.

  def generate_image_tag(order, direction)
    image = image_tag("#{direction}.png")
    link_to image, users_path(order: order, direction: direction)
  end

  def link_to_by_order(link, order_by)
    sort_order = params[:direction] == "asc" ? :desc : :asc
    if link.downcase == params[:order]
      generate_image_tag params[:order], sort_order
    else
      # order = params[:order] == 'name' ? 'email' : 'name'
      sort_by_ascending_image = generate_image_tag order_by, :asc
      sort_by_descending_image = generate_image_tag order_by, :desc
      [sort_by_ascending_image, sort_by_descending_image].join().html_safe
    end
  end

  def admin_or_self_user(user)
    admin_logged_in or user == current_user
  end
end
