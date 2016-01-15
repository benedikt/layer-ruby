module Layer
  module Operations
    module Destroy

      module ClassMethods
        # Destroys the resource with the given id
        #
        # @param id [String] the resource's id
        # @param client [Layer::Client] the client to use to make this request
        # @raise [Layer::Exceptions::Exception] a subclass of Layer::Exceptions::Exception describing the error
        def destroy(id, client = self.client)
          id = Layer::Client.normalize_id(id)
          client.delete("#{url}/#{id}", {}, { params: { destroy: true } })
        end
      end

      # @!visibility private
      def self.included(base)
        base.extend(ClassMethods)
      end

      # Destroys the resource
      #
      # @raise [Layer::Exceptions::Exception] a subclass of Layer::Exceptions::Exception describing the error
      def destroy
        client.delete(url, {}, { params: { destroy: true } })
      end

    end
  end
end
