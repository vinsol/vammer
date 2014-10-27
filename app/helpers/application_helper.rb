module ApplicationHelper

  # fix- Better to return company's complete detail from one method -DONE
  #   e.g. #company_config returning a hash of all the config including name, domain.
  def get_company_details
    YAML.load_file('config/config.yml')['company']
  end

  def admin_logged_in
    current_user.admin
  end

end
