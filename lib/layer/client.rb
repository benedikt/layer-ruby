require 'rest-client'
require 'securerandom'

require 'layer/client/platform'
require 'layer/client/rest'

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

      def normalize_id(id)
        id.to_s.split('/').last
      end

      def authenticate(app_id = self.app_id, &block)
        Layer::Client::REST.new(app_id, &block)
      end
    end

    def get(*args)
      request(:get, *args)
    end

    def post(*args)
      request(:post, *args)
    end

    def patch(url, payload = {}, headers = {})
      headers['Content-Type'] = 'application/vnd.layer-patch+json'

      request(:patch, url, payload, headers)
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
      url = "https://api.layer.com#{url}" unless url.start_with?('https://api.layer.com')

      headers = {
        'Accept' => 'application/vnd.layer+json; version=1.0',
        'Content-Type' => 'application/json',
        'If-None-Match' => SecureRandom.uuid
      }.merge(headers)

      payload = payload.to_json

      response = RestClient::Request.execute(method: method, url: url, payload: payload, headers: headers)
      response.empty? ? nil : JSON.parse(response)
    rescue RestClient::Exception
      raise Layer::Exceptions::Exceptions.build_exception($!)
    end

  end
end
