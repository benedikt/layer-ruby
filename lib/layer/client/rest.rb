module Layer
  class Client
    class REST < Layer::Client

      attr_reader :token

      def initialize(app_id = self.class.app_id)
        client = Layer::Client.new
        nonce = client.post('/nonces')['nonce']
        identity_token = yield(nonce)

        @token = client.post('/sessions', { identity_token: identity_token, app_id: app_id })['session_token']
      end

    private

      def request(method, url, payload = {}, headers = {})
        url = "https://api.layer.com/#{url}" unless url.start_with?('https://api.layer.com')
        headers['Authorization'] ||= "Layer session-token=\"#{token}\""

        super
      end
    end
  end
end
