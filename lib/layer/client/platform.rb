module Layer
  class Client
    class Platform < Layer::Client

      attr_reader :app_id, :token

      def initialize(app_id = Layer::Client.app_id, token = Layer::Client.token)
        @app_id = self.class.normalize_id(app_id)
        @token = token
      end

    private

      def request(method, url, payload = {}, headers = {})
        url = "https://api.layer.com/apps/#{app_id}#{url}" unless url.start_with?('https://api.layer.com')
        headers['Authorization'] ||= "Bearer #{token}"

        super
      end
    end
  end
end
