module Layer
  class Patch
    class Base < SimpleDelegator

      attr_reader :patch

      def initialize(patch, object)
        @patch = patch
        super(prepare_base(object))
      end

      def wrap(property, object)
        case object
        when ::Array
          return Layer::Patch::Array.new(patch.nested(property), object)
        when ::Hash
          return Layer::Patch::Hash.new(patch.nested(property), object)
        else
          object
        end
      end

    end
  end
end
