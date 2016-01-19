module Layer
  module Operations
    module Patch

      # Creates the resource with the given attributes
      #
      # @return [Boolean] whether saving was successful
      # @raise [Layer::Exceptions::Exception] a subclass of Layer::Exceptions::Exception describing the error
      def save
        client.patch(url, patch.operations.dup)
        patch.reset
        true
      end

      # Updates the resource's attributes to the given ones
      #
      # @param [Hash] attributes the new attributes
      # @return [Layer::Patch::Hash] the resources new attributes
      def attributes=(attributes)
        @attributes = Layer::Patch::Hash.new(patch, attributes)
      end

    private

      def patch
        @patch ||= Layer::Patch.new
      end

    end
  end
end
