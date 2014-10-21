module ApplicationHelper

  # fix- Better to return company's complete detail from one method
  #   e.g. #company_config returning a hash of all the config including name, domain.
  def get_company_name
    YAML.load_file('config/config.yml')['company']['name']
  end

  def get_company_domain
    YAML.load_file('config/config.yml')['company']['domain']
  end

  # fix- This should always be update path for settings where multiple records from settings table can be updated in single request
  def edit_or_create_setting_path
    Setting.first ? edit_setting_path(Setting.first) : new_setting_path
  end

end
