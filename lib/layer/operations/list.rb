module Layer
  module Operations
    module List

      module ClassMethods
        # Finds all resources
        #
        # @param client [Layer::Client] the client to use to make this request
        # @return [Enumerable] the found resources
        # @raise [Layer::Exceptions::Exception] a subclass of Layer::Exceptions::Exception describing the error
        def all(client = self.client)
          response = client.get(url)
          response.map { |attributes| from_response(attributes, client) }
        end
      end

      # @!visibility private
      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end
