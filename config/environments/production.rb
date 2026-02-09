Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.server_timing = true
  config.public_file_server.enabled = true
  config.assets.compile = true
  config.active_storage.service = :local
  config.force_ssl = true
  config.log_level = :info
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false

  config.active_job.queue_adapter = :sidekiq

  Sidekiq.configure_server do |sidekiq_config|
    sidekiq_config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
  end

  Sidekiq.configure_client do |sidekiq_config|
    sidekiq_config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
  end
end
