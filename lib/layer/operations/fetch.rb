module Layer
  module Operations
    module Fetch

      module ClassMethods
        # Fetches the singular resource
        #
        # @param client [Layer::Client] the client to use to make this request
        # @return [Layer::Resource] the found resource
        # @raise [Layer::Exceptions::Exception] a subclass of Layer::Exceptions::Exception describing the error
        def fetch(client = self.client)
          response = client.get(url)
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
