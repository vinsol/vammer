#FIXME_AB: You may also like to format this YML file like database.yml, where you can specify settings for different envs like development, production etc. This is a best practice.
begin
  COMPANY = YAML.load_file('config/config.yml')['development']['company']
  raise unless COMPANY
rescue StandardError
  raise 'Company configurations not found'
end