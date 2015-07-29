module Layer
  module Operations
    module Find

      module ClassMethods
        def find(id, client = self.client)
          id = Layer::Client.normalize_id(id)
          response = client.get("#{url}/#{id}")
          from_response(response, client)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      def reload
        self.attributes = client.get(url)
        self
      end

    end
  end
end
