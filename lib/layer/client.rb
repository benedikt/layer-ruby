require 'rest-client'
require 'securerandom'

module Layer
  class Client
    class << self
      attr_writer :app_id, :token

      def app_id
        @app_id || ENV['LAYER_APP_ID']
      end

      def token
        @token ||= ENV['LAYER_PLATFORM_TOKEN']
      end

      def configure
        yield self
      end
    end

    attr_reader :app_id, :token

    def initialize(app_id = self.class.app_id, token = self.class.token)
      @app_id = app_id
      @token = token
    end

    def get(*args)
      request(:get, *args)
    end

    def post(*args)
      request(:post, *args)
    end

    def patch(*args)
      request(:patch, *args)
    end

    def put(*args)
      request(:put, *args)
    end

    def delete(*args)
      request(:delete, *args)
    end

    def head(*args)
      request(:head, *args)
    end

    def options(*args)
      request(:options, *args)
    end

  private

    def request(method, url, payload = {}, headers = {})
      url = "https://api.layer.com/apps/#{app_id}#{url}" unless url.start_with?('https://api.layer.com')

      headers = {
        'Authorization' => "Bearer #{token}",
        'Accept' => 'application/vnd.layer+json; version=1.0',
        'Content-Type' => 'application/json',
        'If-None-Match' => SecureRandom.uuid
      }.merge(headers)

      payload = payload.to_json

      response = RestClient::Request.execute(method: method, url: url, payload: payload, headers: headers)
      response.empty? ? nil : JSON.parse(response)
    end

  end
end
