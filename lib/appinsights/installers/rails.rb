require_relative 'base'

module AppInsights
  class RailsInstaller < Rails::Railtie
    initializer 'appinsights.start_plugin' do |_app|
      init Rails.root
    end

    def init(root, filename = nil)
      installer = AppInsights::BaseInstaller.new config.app_middleware,
                                                 root,
                                                 filename,
                                                 Rails.logger

      installer.install

      if ENV.fetch('APPINSIGHTS_LOGGING_ENABLED', 'true') == 'false'
        Rails.logger = AppInsights::LoggerProxy.new Rails.logger
      end
    end
  end
end
