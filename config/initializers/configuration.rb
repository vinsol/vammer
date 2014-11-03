module Configuration
  COMPANY = YAML.load_file('config/config.yml')['company']
end