OAUTH = YAML.load_file(File.join(Rails.root, "config", "oauth.yml"))

# load all the possible oauth strategies
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :mindvalley, Settings.mindvalley.accounts.key,
    Settings.mindvalley.accounts.secret
end