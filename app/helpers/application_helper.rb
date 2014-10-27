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

  #FIX: When user visits the index page for first time, each field should have links to sort in asc/desc order.
  #FIX: When the list is sorted on a field, that field should have the link to order in opposite direction and other fields should have both links.
  #FIX: Use something else instead of variable names 'link' and 'order'. Something more clear.
  def link_to_by_order(link, params, order)
    sort_order = params[:direction] == "asc" ? :desc : :asc
    if link.downcase == params[:order]
      link_to link, users_path(order: order, direction: sort_order), class: "#{params[:direction]}"
    else
      link_to link, users_path(order: order, direction: sort_order)
    end
  end

end
