module ApplicationHelper

  #FIX: Rename. Use just #company_config.
  def company_config
    YAML.load_file('config/config.yml')['company']
  end

  def admin_logged_in
    current_user.admin
  end

  def link_to_by_order(link, params, order)
    sort_order = params[:direction] == "asc" ? :desc : :asc
    if link.downcase == params[:order]
      link_to link, users_path(order: order, direction: sort_order), class: "#{params[:direction]}"
    else
      link_to link, users_path(order: order, direction: sort_order)
    end
  end

end
