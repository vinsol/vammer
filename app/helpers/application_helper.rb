module ApplicationHelper

  def get_company_name
    YAML.load_file('config/config.yml')['company']['name']
  end

  def get_company_domain
    YAML.load_file('config/config.yml')['company']['domain']
  end

end
