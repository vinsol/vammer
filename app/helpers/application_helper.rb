module ApplicationHelper

  # fix- Better to return company's complete detail from one method -DONE
  #   e.g. #company_config returning a hash of all the config including name, domain.
  def get_company_details
    YAML.load_file('config/config.yml')['company']
  end

  # fix- This should always be update path for settings where multiple records from settings table can be updated in single request
  def edit_or_create_setting_path
    edit_setting_path(Setting.first)
  end

end
