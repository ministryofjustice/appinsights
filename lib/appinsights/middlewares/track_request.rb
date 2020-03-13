require 'application_insights'

module AppInsights
  class TrackRequest
    def initialize(app, instrumentation_key, ignore_prefixes = [], buffer_size = 500, send_interval = 60)
      @app = app
      @ignore_prefixes = ignore_prefixes
      @track_request = ApplicationInsights::Rack::TrackRequest.new(app, instrumentation_key, buffer_size, send_interval)
    end

    def call(env)
      path_info = env['PATH_INFO']
      if @ignore_prefixes.any? { |prefix| path_info.start_with?(prefix) }
        @app.call env
      else
        @track_request.call env
      end
    end
  end
end
