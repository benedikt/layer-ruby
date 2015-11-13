module Layer
  module Operations
    module Create

      module ClassMethods
        # Creates the resource with the given attributes
        #
        # @param attributes [Hash] the resource's attributes
        # @param client [Layer::Client] the client to use to make this request
        # @return [Layer::Resource] the created resource
        # @raise [Layer::Exceptions::Exception] a subclass of Layer::Exceptions::Exception describing the error
        def create(attributes = {}, client = self.client)
          response = client.post(url, attributes)
          from_response(response, client)
        end
      end

      # @!visibility private
      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end
