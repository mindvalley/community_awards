OAUTH = YAML.load_file(File.join(Rails.root, "config", "oauth.yml"))

# load all the possible oauth strategies
Rails.application.config.middleware.use OmniAuth::Builder do
  # binding.pry
  provider :mindvalley, OAUTH[Rails.env]['mindvalley']['consumer_key'],
    OAUTH[Rails.env]['mindvalley']['consumer_secret']
end