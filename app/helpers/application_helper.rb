module ApplicationHelper

  #FIX: Rename. Use just #company_config.
  def get_company_details
    YAML.load_file('config/config.yml')['company']
  end

end
