module Layer
  module Operations
    module List

      module ClassMethods
        def all(client = self.client)
          response = client.get(url)
          response.map { |attributes| from_response(attributes, client) }
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

    end
  end
end
