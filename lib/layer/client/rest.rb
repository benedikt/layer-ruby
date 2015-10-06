module Layer
  class Client
    class REST < Layer::Client

      def self.authenticate(app_id, nonce = nil)
        client = Layer::Client.new

        nonce ||= client.post('/nonces')['nonce']

        identity_token = yield(nonce)

        response = client.post('/sessions', { identity_token: identity_token, app_id: app_id })
        response['session_token']
      end

      attr_reader :token, :app_id, :block

      def initialize(app_id = self.class.app_id, &block)
        @app_id = self.class.normalize_id(app_id)
        @block = block
        authenticate
      end

    private

      def request(method, url, payload = {}, headers = {})
        url = "https://api.layer.com#{url}" unless url.start_with?('https://api.layer.com')
        headers['Authorization'] ||= "Layer session-token=\"#{token}\""

        super
      rescue Layer::Exceptions::AuthenticationRequired => exception
        authenticate(exception.response_json['data']['nonce'])
        retry
      end

      def authenticate(nonce = nil)
        @token = self.class.authenticate(app_id, nonce, &block)
      end
    end
  end
end
