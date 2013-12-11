require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

Bundler.require(:default, Rails.env)

module Corto
  class Application < Rails::Application
    config.time_zone              = 'Madrid'
    config.i18n.default_locale    = :es
    config.i18n.available_locales = [:en, :es]

    config.generators do |g|
      g.template_engine     :haml
      g.test_framework      :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.view_specs          false
      g.helper_specs        false
      g.stylesheets       = false
      g.javascripts       = false
      g.helper            = false
    end

    config.filter_parameters += [ :password, :password_confirmation ]
  end
end
