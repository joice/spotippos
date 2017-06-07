require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.secrets.redis_url, size: 9, namespace: "spotipposland-#{Rails.env}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.secrets.redis_url, size: 1, namespace: "spotipposland-#{Rails.env}" }
end
