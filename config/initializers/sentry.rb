if Rails.env.production?
  Sentry.init do |config|
    config.dsn = ENV.fetch("SENTRY_DSN")
    config.send_default_pii = true
  end
end
