require_relative 'helper'
require_relative 'mock/mock_app'
require 'application_insights'

describe AppInsights::TrackRequest do
  before do
    @app = MockApp.new
  end

  it 'just calls app when ignored' do
    tracker = AppInsights::TrackRequest.new @app, '', ['/ignored']
    tracker.call({'PATH_INFO' => '/ignored'})
    assert_equal 1, @app.callcount
  end

  it 'calls tracker when not ignored' do
    module ApplicationInsights
      module Rack
        class TrackRequest
          def call _env
          end
        end
      end
    end
    tracker = AppInsights::TrackRequest.new @app, '', ['/ignored']
    tracker.call({'PATH_INFO' => '/real'})
    assert_equal 0, @app.callcount
  end
end
