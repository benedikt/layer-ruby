module Layer
  class User < Resource

    def self.find(id, client = self.client)
      from_response({ 'url' => "/users/#{id}" }, client)
    end

    # Returns the users blocked by this user
    #
    # @return [Layer::RelationProxy] the users the user blocks
    # @!macro platform-api
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

    # Returns the identity object for this user
    #
    # @return [Layer::RelationProxy] identity object
    # @!macro platform-api
    def identity
      RelationProxy.new(self, Identity, [Operations::Create]) do
        def get(client = self.client)
          response = client.get(url)
          from_response(response, client)
        end

        def delete(client = self.client)
          client.delete(url)
        end
      end
    end

    # Returns the user's conversations
    #
    # @return [Layer::RelationProxy] the user's conversations
    # @!macro platform-api
    def conversations
      RelationProxy.new(self, Conversation, [Operations::List, Operations::Find])
    end

    # Returns the user's messages
    #
    # @return [Layer::RelationProxy] the user's messages
    # @!macro platform-api
    def messages
      RelationProxy.new(self, Message, [Operations::Find])
    end
  end
end
