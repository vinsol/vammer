#FIXME_AB: You may also like to format this YML file like database.yml, where you can specify settings for different envs like development, production etc. This is a best practice.
COMPANY = YAML.load_file('config/config.yml')['company']
