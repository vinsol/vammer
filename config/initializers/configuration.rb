#FIXME_AB: You may also like to format this YML file like database.yml, where you can specify settings for different envs like development, production etc. This is a best practice.
begin
  #FIX: Do not hard code for development env.
  COMPANY = YAML.load_file('config/config.yml')['development']['company']
  #FIX: This can be removed. Check for name, domain only
  raise unless COMPANY
rescue StandardError
  raise 'Company configuration not found or is invalid'
end