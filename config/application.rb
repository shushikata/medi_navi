require_relative 'boot'

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MediNavi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.generators.template_engine = :slim
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'

    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        html_tag.html_safe
      else
        class_name = instance.object.class.name.underscore
        method_name = instance.instance_variable_get(:@method_name)
        "<div class=\"has-error\">#{html_tag}
          <span class=\"help-block\">
            #{instance.error_message.first}
          </span>
        </div>".html_safe
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.generators do |g|
      g.test_framework :rspec,
                      fixtures: true,
                      view_specs: false,
                      helper_specs: false,
                      routing_specs: false,
                      controller_specs: false,
                      request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end

  end
end


