module Layer
  class Patch
    class Array < Base

      def prepare_base(base)
        base.each_with_index.map do |(value, index)|
          wrap(index, value)
        end
      end

      def []=(index, value)
        patch.add_index(index, value)
        super
      end

      def <<(value)
        patch.add(value)
        super
      end
      alias :push :<<

      def unshift(value)
        patch.add_index(0, value)
        super
      end

      def concat(values)
        values.each { |value| patch.add(value) }
        super
      end

      def insert(offset, values)
        values.each_with_index { |value, index| patch.add_index(offset + index, value) }
        super
      end

      def clear
        patch.replace([])
        super
      end

      def delete_at(index)
        patch.remove_index(index)
        super
      end

      def delete(value)
        patch.remove(value)
        super
      end

      def pop
        patch.remove_index(length)
        super
      end

      def shift
        patch.remove_index(0)
        super
      end

      def replace(values)
        patch.replace(values)
        super
      end

    end
  end
end
