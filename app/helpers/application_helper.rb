module ApplicationHelper

  #FIX: Rename. Use just #company_config.
  def company_config
    YAML.load_file('config/config.yml')['company']
  end

end
