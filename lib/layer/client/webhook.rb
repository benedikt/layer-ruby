module Layer
  class Client
    class Webhook < Platform

    private

      def request(method, url, payload = {}, headers = {})
        headers = {
          'Accept' => 'application/vnd.layer.webhooks+json; version=1.0',
          'Content-Type' => 'application/json'
        }.merge(headers)

        super
      end

    end
  end
end
