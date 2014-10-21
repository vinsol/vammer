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

  def link_to_by_order(link, params, criteria)
    sort_order = params[:direction] == "asc" ? :desc : :asc
    link_to link, users_path(order: criteria, direction: sort_order)
  end

end
