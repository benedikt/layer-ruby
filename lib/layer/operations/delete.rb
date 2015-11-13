module Layer
  module Operations
    module Delete

      module ClassMethods
        # Deletes the resource with the given id
        #
        # @param id [String] the resource's id
        # @param client [Layer::Client] the client to use to make this request
        # @raise [Layer::Exceptions::Exception] a subclass of Layer::Exceptions::Exception describing the error
        def delete(id, client = self.client)
          id = Layer::Client.normalize_id(id)
          client.delete("#{url}/#{id}")
        end
      end

      # @!visibility private
      def self.included(base)
        base.extend(ClassMethods)
      end

      # Deletes the resource
      #
      # @raise [Layer::Exceptions::Exception] a subclass of Layer::Exceptions::Exception describing the error
      def delete
        client.delete(url)
      end

    end
  end
end
