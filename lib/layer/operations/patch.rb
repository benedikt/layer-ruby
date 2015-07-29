module Layer
  module Operations
    module Patch

      def save
        client.patch(url, patch.operations)
        patch.reset
        true
      end

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
