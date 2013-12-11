Corto::Application.configure do
  config.cache_classes                     = false
  config.eager_load                        = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.active_support.deprecation        = :log
  config.active_record.migration_error     = :page_load
  config.assets.debug                      = true

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default :charset => "utf-8"
  config.action_mailer.smtp_settings = {
    # :address              => "smtp.mandrillapp.com",
    # :port                 => 25,
    # :enable_starttls_auto => true,
    # :user_name            => ENV['MANDRILL_USERNAME'],
    # :password             => ENV['MANDRILL_API_KEY'],
    # :authentication       => 'login',
    # :domain               => 'localhost:3000',
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "gmail.com",
    :authentication       => "plain",
    :enable_starttls_auto => true,
    :user_name            => ENV["GMAIL_USERNAME"],
    :password             => ENV["GMAIL_PASSWORD"]
  }

  BetterErrors::Middleware.allow_ip! "10.0.2.2"
end
