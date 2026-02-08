Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true
  config.active_storage.service = :local
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "gmail.com",
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"],
    authentication: "plain",
    enable_starttls_auto: true
  }


  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { host: "localhost", port: 3000 }
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
  config.assets.debug = true
  config.assets.quiet = true
  # config.action_mailer.delivery_method = :letter_opener


  config.active_job.queue_adapter = :sidekiq

  Sidekiq.configure_server do |sidekiq_config|
    sidekiq_config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
  end

  Sidekiq.configure_client do |sidekiq_config|
    sidekiq_config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
  end
end
