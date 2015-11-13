module Layer
  module Operations
    module Paginate

      module ClassMethods
        # Finds all resources from a paginated endpoint
        #
        # @param client [Layer::Client] the client to use to make this request
        # @return [Layer::ResourceCollection] the found resources
        # @raise [Layer::Exceptions::Exception] a subclass of Layer::Exceptions::Exception describing the error
        def all(client = self.client)
          Layer::ResourceCollection.new(self, client)
        end
      end

      # @!visibility private
      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end
