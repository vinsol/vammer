#FIX: Use as a constant only. No need to wrap it in a module
COMPANY = YAML.load_file('config/config.yml')['company']
