module Layer
  module Operations
    module Find

      module ClassMethods
        # Finds the resource with the given id
        #
        # @param id [String] the resource's id
        # @param client [Layer::Client] the client to use to make this request
        # @return [Layer::Resource] the found resource
        # @raise [Layer::Exceptions::Exception] a subclass of Layer::Exceptions::Exception describing the error
        def find(id, client = self.client)
          id = Layer::Client.normalize_id(id)
          response = client.get("#{url}/#{id}")
          from_response(response, client)
        end
      end

      # @!visibility private
      def self.included(base)
        base.extend(ClassMethods)
      end

      # Reloads the resource
      #
      # @return [Layer::Resource] the resource itself
      # @raise [Layer::Exceptions::Exception] a subclass of Layer::Exceptions::Exception describing the error
      def reload
        self.attributes = client.get(url)
        self
      end

    end
  end
end
