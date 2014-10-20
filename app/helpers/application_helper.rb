module ApplicationHelper

  def get_company_name
    YAML.load_file('config/config.yml')['company']['name']
  end

  def get_company_domain
    YAML.load_file('config/config.yml')['company']['domain']
  end

  def edit_or_create_setting_path
    Setting.first ? edit_setting_path(Setting.first) : new_setting_path
  end

end
