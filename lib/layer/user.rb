module Layer
  class User < Resource

    def self.find(id, client = self.client)
      from_response({ 'url' => "/users/#{id}" }, client)
    end

    def blocks
      RelationProxy.new(self, Block, [Operations::Create, Operations::List, Operations::Delete]) do
        def from_response(response, client)
          response['url'] ||= "#{base.url}#{resource_type.url}/#{response['user_id']}"
          super
        end

        def create(attributes, client = self.client)
          response = client.post(url, attributes)
          from_response({ 'user_id' => attributes['user_id'] }, client)
        end
      end
    end

  end
end
