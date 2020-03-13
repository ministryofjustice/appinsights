require 'application_insights'

module AppInsights
  class TrackRequest
    def initialize(app, instrumentation_key, prefixes_to_ignore = [], buffer_size = 500, send_interval = 60)
      @app = app
      @prefixes_to_ignore = prefixes_to_ignore
      @track_request = ApplicationInsights::Rack::TrackRequest.new(app, instrumentation_key, buffer_size, send_interval)
    end

    def call(env)
      path_info = env['PATH_INFO']
      if @prefixes_to_ignore.any? { |prefix| path_info.start_with?(prefix) }
        @app.call env
      else
        @track_request.call env
      end
    end
  end
end
