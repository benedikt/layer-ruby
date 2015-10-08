module Layer
  module Operations
    module Paginate

      module ClassMethods
        def all(client = self.client)
          Layer::ResourceCollection.new(self, client)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end
