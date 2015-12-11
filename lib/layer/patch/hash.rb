module Layer
  class Patch
    class Hash < Base

      def prepare_base(base)
        base.each_pair do |key, value|
          base[key] = wrap(key, value)
        end
      end

      def []=(key, value)
        patch.set(key, value.dup)
        super(key, wrap(key, value))
      end
      alias :store :[]=

      def clear
        patch.replace({})
        super
      end

      def delete(key)
        patch.delete(key)
        super
      end

      def delete_if(&block)
        super do |key, value|
          result = yield(key, value)
          delete(key) if result
          result
        end
      end
      alias :reject! :delete_if

      def shift
        patch.delete(keys.first)
        super
      end

      def replace(other_hash)
        patch.replace(other_hash)
        super
      end

      def merge!(other_hash)
        other_hash.each_pair do |key, value|
          patch.set(key, value)
        end
        super
      end

    end
  end
end
