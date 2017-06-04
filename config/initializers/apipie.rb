Apipie.configure do |config|
  config.app_name                = 'Spotippos'
  config.api_base_url["1.0"]     = '/api/v1/'
  config.doc_base_url            = '/docs'
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
  config.api_routes              = Rails.application.routes
  config.validate                = false
  config.app_info["1.0"] = "Come to Spotippos and find the house of your dreams!"
end
