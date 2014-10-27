module ApplicationHelper

  # fix- Better to return company's complete detail from one method -DONE
  #   e.g. #company_config returning a hash of all the config including name, domain.
  def get_company_details
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
